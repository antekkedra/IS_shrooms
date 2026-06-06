Auth.requireAuth();

// ── Init ────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', async () => {
    const user = await Api.getMe();
    if (!user) return;

    Auth.setUser(user);
    document.getElementById('navUsername').textContent = user.username;

    if (user.role === 'ROLE_ADMIN') {
        document.getElementById('tabAdmin').classList.remove('hidden');
        document.getElementById('adminBadge').classList.remove('hidden');
        document.getElementById('adminRole').textContent = user.role;
    }

    document.getElementById('logoutBtn').addEventListener('click', () => Auth.logout());
    initTabs();
    loadFungi();
});

// ── Tabs ─────────────────────────────────────────────────────
function initTabs() {
    document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
            document.querySelectorAll('.tab-pane').forEach(p => p.classList.remove('active'));
            btn.classList.add('active');
            document.getElementById(btn.dataset.target).classList.add('active');
        });
    });
}

// ── Helpers ───────────────────────────────────────────────────
function escHtml(v) {
    if (v === null || v === undefined) return '<span style="color:#bbb">—</span>';
    return String(v).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
}

function renderTable(tbodyId, rows) {
    const tbody = document.getElementById(tbodyId);
    if (!rows || rows.length === 0) {
        tbody.innerHTML = `<tr><td colspan="99" class="no-data">Brak danych</td></tr>`;
        return;
    }
    tbody.innerHTML = rows.map(r => `<tr>${Object.values(r).map(v => `<td>${escHtml(v)}</td>`).join('')}</tr>`).join('');
}

function setLoading(tbodyId, cols) {
    document.getElementById(tbodyId).innerHTML =
        `<tr><td colspan="${cols}" class="no-data">Ładowanie…</td></tr>`;
}

function showAlert(id, message, type) {
    const el = document.getElementById(id);
    el.className = `alert alert-${type === 'success' ? 'success' : 'error'}`;
    el.textContent = message;
    el.classList.remove('hidden');
    setTimeout(() => el.classList.add('hidden'), 4000);
}

// ── Fungi ─────────────────────────────────────────────────────
async function loadFungi() {
    setLoading('fungiBody', 8);
    const data = await Api.getFungi();
    renderFungiTable(data);
}

function renderFungiTable(data) {
    const rows = (data || []).map(f => ({
        id:        f.id,
        species:   f.species,
        genus:     f.genus,
        family:    f.family,
        country:   f.country,
        latitude:  f.latitude?.toFixed(4),
        longitude: f.longitude?.toFixed(4),
        eventDate: f.eventDate
    }));
    renderTable('fungiBody', rows);
}

document.getElementById('searchSpeciesBtn').addEventListener('click', async () => {
    const val = document.getElementById('searchSpecies').value.trim();
    if (!val) { loadFungi(); return; }
    setLoading('fungiBody', 8);
    const data = await Api.searchFungi(val);
    renderFungiTable(data);
});

document.getElementById('searchSpecies').addEventListener('keydown', e => {
    if (e.key === 'Enter') document.getElementById('searchSpeciesBtn').click();
});

document.getElementById('exportFungiBtn').addEventListener('click', () => Api.exportXml('fungi'));

// ── Soil ──────────────────────────────────────────────────────
document.getElementById('tabSoil').addEventListener('click', async () => {
    if (document.getElementById('soilBody').dataset.loaded) return;
    setLoading('soilBody', 9);
    const data = await Api.getSoil();
    const rows = (data || []).map(s => ({
        id:           s.id,
        ph:           s.ph?.toFixed(2),
        organicCarbon:s.organicCarbon?.toFixed(2),
        clay:         s.clay?.toFixed(1),
        sand:         s.sand?.toFixed(1),
        silt:         s.silt?.toFixed(1),
        soilMoisture: s.soilMoisture?.toFixed(2),
        depth:        s.depth,
        latitude:     s.latitude?.toFixed(4),
        longitude:    s.longitude?.toFixed(4)
    }));
    renderTable('soilBody', rows);
    document.getElementById('soilBody').dataset.loaded = '1';
});

document.getElementById('exportSoilBtn').addEventListener('click', () => Api.exportXml('soil'));

// ── Analysis ──────────────────────────────────────────────────
let _occurrenceData      = [];
let _weatherData         = [];
let _weatherFungiResults = [];
let _phChart = null, _moistureChart = null, _carbonChart = null;
let _tempChart = null, _precipChart = null, _windChart = null;

document.getElementById('tabAnalysis').addEventListener('click', async () => {
    if (!document.getElementById('speciesSelector').dataset.loaded) {
        await loadCharts();
    }
});

document.getElementById('analyzeFamilyBtn').addEventListener('click', async () => {
    const family = document.getElementById('analyzeFamily').value.trim();
    if (!family) return;
    const result = document.getElementById('familyResult');
    result.classList.add('hidden');

    const dto = await Api.analyzeFamily(family);
    if (!dto) {
        result.innerHTML = '<div class="alert alert-error">Nie znaleziono danych dla podanej rodziny.</div>';
        result.classList.remove('hidden');
        return;
    }

    result.innerHTML = `
        <div class="summary-card">
            <h3>Analiza rodziny: <em>${escHtml(dto.family)}</em></h3>
            <div class="summary-grid">
                <div class="stat-box"><div class="stat-value">${escHtml(dto.occurrences)}</div><div class="stat-label">Wystąpienia</div></div>
                <div class="stat-box"><div class="stat-value">${dto.avgPh?.toFixed(2) ?? '—'}</div><div class="stat-label">Śr. pH gleby</div></div>
                <div class="stat-box"><div class="stat-value">${dto.avgMoisture?.toFixed(2) ?? '—'}</div><div class="stat-label">Śr. wilgotność</div></div>
                <div class="stat-box"><div class="stat-value">${dto.avgCarbon?.toFixed(2) ?? '—'}</div><div class="stat-label">Śr. węgiel org.</div></div>
            </div>
        </div>`;
    result.classList.remove('hidden');
});

document.getElementById('exportAnalysisBtn').addEventListener('click', exportAnalysisXml);

// ── Analysis XML export ───────────────────────────────────────
function xmlEsc(v) {
    if (v == null) return '';
    return String(v)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
}

function histogramBins(data, field, binSize) {
    const counts = {};
    data.forEach(d => {
        const val = d[field];
        if (val == null || isNaN(val)) return;
        const bin = Math.round(val / binSize) * binSize;
        const key = bin.toFixed(2);
        counts[key] = (counts[key] || 0) + 1;
    });
    return Object.keys(counts).sort((a, b) => +a - +b).map(k => ({ value: k, count: counts[k] }));
}

function chartXml(indent, nazwa, kolumnaWartosci, etykietaWartosci, bins) {
    const i1 = indent, i2 = indent + '  ', i3 = indent + '    ';
    const rows = bins.map(b =>
        `${i2}<wiersz>\n${i3}<${kolumnaWartosci}>${b.value}</${kolumnaWartosci}>\n${i3}<LiczbaWystapien>${b.count}</LiczbaWystapien>\n${i2}</wiersz>`
    ).join('\n');
    return [
        `${i1}<wykres nazwa="${xmlEsc(nazwa)}">`,
        `${i2}<kolumny>${xmlEsc(etykietaWartosci)} | LiczbaWystapien</kolumny>`,
        rows,
        `${i1}</wykres>`
    ].join('\n');
}

function exportAnalysisXml() {
    if (!_occurrenceData.length && !_weatherData.length) {
        alert('Dane wykresów nie zostały jeszcze załadowane. Otwórz zakładkę Analiza i poczekaj na załadowanie.');
        return;
    }

    const [tempMin,   tempMax]   = _sliderTemp.noUiSlider.get(true);
    const [precipMin, precipMax] = _sliderPrecip.noUiSlider.get(true);
    const [windMin,   windMax]   = _sliderWind.noUiSlider.get(true);

    const soilDefs = [
        { nazwa: 'pH gleby',          kolumna: 'pH',               etykieta: 'pH',               field: 'ph',            binSize: 0.5 },
        { nazwa: 'Wilgotność gleby',   kolumna: 'Wilgotnosc',       etykieta: 'Wilgotnosc',       field: 'soilMoisture',  binSize: 5   },
        { nazwa: 'Węgiel organiczny',  kolumna: 'WegielOrganiczny', etykieta: 'WegielOrganiczny', field: 'organicCarbon', binSize: 2   }
    ];
    const weatherDefs = [
        { nazwa: 'Temperatura',       kolumna: 'Temperatura_C',       etykieta: 'Temperatura_C',       field: 'temperatureMean',  binSize: 1 },
        { nazwa: 'Opad atmosferyczny', kolumna: 'Opad_mm',            etykieta: 'Opad_mm',             field: 'precipitationSum', binSize: 1 },
        { nazwa: 'Prędkość wiatru',    kolumna: 'PredkoscWiatru_ms',  etykieta: 'PredkoscWiatru_ms',   field: 'windSpeedMean',    binSize: 1 }
    ];

    const lines = [];
    lines.push('<?xml version="1.0" encoding="UTF-8"?>');
    lines.push('<raportAnalizy>');

    // Zakresy pogodowe
    lines.push('  <zakresyPogodowe>');
    lines.push(`    <temperatura   min="${tempMin}"   max="${tempMax}"   jednostka="°C"/>`);
    lines.push(`    <opad          min="${precipMin}" max="${precipMax}" jednostka="mm"/>`);
    lines.push(`    <predkoscWiatru min="${windMin}"  max="${windMax}"   jednostka="m/s"/>`);
    lines.push('  </zakresyPogodowe>');

    // Grzyby pasujące do warunków pogodowych
    lines.push(`  <grzybyWWarunkachPogodowych liczba="${_weatherFungiResults.length}">`);
    _weatherFungiResults.forEach(f => {
        lines.push('    <grzyb>');
        lines.push(`      <id>${xmlEsc(f.id)}</id>`);
        lines.push(`      <gatunek>${xmlEsc(f.species)}</gatunek>`);
        lines.push(`      <rodzaj>${xmlEsc(f.genus)}</rodzaj>`);
        lines.push(`      <rodzina>${xmlEsc(f.family)}</rodzina>`);
        lines.push(`      <kraj>${xmlEsc(f.country)}</kraj>`);
        lines.push(`      <szerokosc>${xmlEsc(f.latitude?.toFixed(4))}</szerokosc>`);
        lines.push(`      <dlugosc>${xmlEsc(f.longitude?.toFixed(4))}</dlugosc>`);
        lines.push(`      <dataZdarzenia>${xmlEsc(f.eventDate)}</dataZdarzenia>`);
        lines.push('    </grzyb>');
    });
    lines.push('  </grzybyWWarunkachPogodowych>');

    // Dane wykresów glebowych
    lines.push('  <wykresyGlebowe>');
    soilDefs.forEach(def => {
        const bins = histogramBins(_occurrenceData, def.field, def.binSize);
        lines.push(chartXml('    ', def.nazwa, def.kolumna, def.etykieta, bins));
    });
    lines.push('  </wykresyGlebowe>');

    // Dane wykresów pogodowych
    lines.push('  <wykresyPogodowe>');
    weatherDefs.forEach(def => {
        const bins = histogramBins(_weatherData, def.field, def.binSize);
        lines.push(chartXml('    ', def.nazwa, def.kolumna, def.etykieta, bins));
    });
    lines.push('  </wykresyPogodowe>');

    lines.push('</raportAnalizy>');

    const xml  = lines.join('\n');
    const blob = new Blob([xml], { type: 'application/xml' });
    const url  = URL.createObjectURL(blob);
    const a    = Object.assign(document.createElement('a'), { href: url, download: 'analiza.xml' });
    a.click();
    URL.revokeObjectURL(url);
}

// ── Weather filter ─────────────────────────────────────────────
function makeSlider(id, labelId, min, max, start, step, unit) {
    const el = document.getElementById(id);
    noUiSlider.create(el, {
        start,
        connect: true,
        range: { min, max },
        step,
        tooltips: [
            { to: v => (Number.isInteger(step) ? Math.round(v) : Math.round(v * 10) / 10) + unit },
            { to: v => (Number.isInteger(step) ? Math.round(v) : Math.round(v * 10) / 10) + unit }
        ]
    });
    const label = document.getElementById(labelId);
    el.noUiSlider.on('update', vals => {
        label.textContent = `${vals[0]} – ${vals[1]}`;
    });
    return el;
}

const _sliderTemp   = makeSlider('tempSlider',   'tempRangeLabel',   -10, 35, [-10, 35], 1,   '°C');
const _sliderPrecip = makeSlider('precipSlider', 'precipRangeLabel',   0, 50, [0,   50], 0.5, ' mm');
const _sliderWind   = makeSlider('windSlider',   'windRangeLabel',     0, 40, [0,   40], 0.5, ' m/s');

document.getElementById('weatherSearchBtn').addEventListener('click', async () => {
    const [tempMin,   tempMax]   = _sliderTemp.noUiSlider.get(true);
    const [precipMin, precipMax] = _sliderPrecip.noUiSlider.get(true);
    const [windMin,   windMax]   = _sliderWind.noUiSlider.get(true);

    setLoading('weatherFungiBody', 8);
    const data = await Api.getFungiByWeather(tempMin, tempMax, precipMin, precipMax, windMin, windMax);
    _weatherFungiResults = data || [];
    const rows = _weatherFungiResults.map(f => ({
        id:        f.id,
        species:   f.species,
        genus:     f.genus,
        family:    f.family,
        country:   f.country,
        latitude:  f.latitude?.toFixed(4),
        longitude: f.longitude?.toFixed(4),
        eventDate: f.eventDate
    }));
    if (rows.length === 0) {
        document.getElementById('weatherFungiBody').innerHTML =
            `<tr><td colspan="8" class="no-data">Brak grzybów dla wybranych warunków pogodowych</td></tr>`;
    } else {
        renderTable('weatherFungiBody', rows);
    }
});

async function loadCharts() {
    [_occurrenceData, _weatherData] = await Promise.all([
        Api.getOccurrenceData(),
        Api.getWeatherOccurrenceData()
    ]);

    const selector = document.getElementById('speciesSelector');
    const families = [...new Set(_occurrenceData.map(d => d.family).filter(Boolean))].sort();
    selector.innerHTML = '<option value="">Wszystkie rodziny</option>' +
        families.map(f => `<option value="${f}">${escHtml(f)}</option>`).join('');
    selector.dataset.loaded = '1';

    renderCharts('');
    renderWeatherCharts();
}

document.getElementById('speciesSelector').addEventListener('change', function () {
    renderCharts(this.value);
});

function renderCharts(selectedFamily) {
    const data = selectedFamily
        ? _occurrenceData.filter(d => d.family === selectedFamily)
        : _occurrenceData;

    _phChart       = buildHistogram('chartPh',       _phChart,       data, 'ph',            'pH gleby',         0.5, '#2d6a3f', 'rgba(45,106,63,0.75)');
    _moistureChart = buildHistogram('chartMoisture', _moistureChart, data, 'soilMoisture',  'Wilgotność gleby', 5,   '#1e6091', 'rgba(30,96,145,0.75)');
    _carbonChart   = buildHistogram('chartCarbon',   _carbonChart,   data, 'organicCarbon', 'Węgiel organiczny',2,   '#7b4f12', 'rgba(123,79,18,0.75)');
}

function renderWeatherCharts() {
    _tempChart   = buildHistogram('chartTemp',   _tempChart,   _weatherData, 'temperatureMean',  'Temperatura (°C)', 1, '#8d3b2b', 'rgba(141,59,43,0.75)');
    _precipChart = buildHistogram('chartPrecip', _precipChart, _weatherData, 'precipitationSum', 'Opad (mm)',        1, '#1565c0', 'rgba(21,101,192,0.75)');
    _windChart   = buildHistogram('chartWind',   _windChart,   _weatherData, 'windSpeedMean',    'Prędkość wiatru (m/s)', 1, '#4a148c', 'rgba(74,20,140,0.75)');
}

function buildHistogram(canvasId, existingChart, data, field, axisLabel, binSize, borderColor, fillColor) {
    const ctx = document.getElementById(canvasId).getContext('2d');
    if (existingChart) existingChart.destroy();

    const counts = {};
    data.forEach(d => {
        const val = d[field];
        if (val == null || isNaN(val)) return;
        const bin = Math.round(val / binSize) * binSize;
        const key = bin.toFixed(2);
        counts[key] = (counts[key] || 0) + 1;
    });

    const sortedKeys = Object.keys(counts).sort((a, b) => +a - +b);

    return new Chart(ctx, {
        type: 'bar',
        data: {
            labels: sortedKeys,
            datasets: [{
                label: 'Liczba wystąpień',
                data: sortedKeys.map(k => counts[k]),
                backgroundColor: fillColor,
                borderColor,
                borderWidth: 1,
                borderRadius: 3
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false },
                tooltip: {
                    callbacks: {
                        title: items => `${axisLabel}: ${items[0].label}`,
                        label: item => `Wystąpienia: ${item.parsed.y}`
                    }
                }
            },
            scales: {
                x: {
                    title: { display: true, text: axisLabel },
                    ticks: { maxRotation: 45 }
                },
                y: {
                    title: { display: true, text: 'Liczba wystąpień' },
                    beginAtZero: true,
                    ticks: { stepSize: 1, precision: 0 }
                }
            }
        }
    });
}

// ── Admin ─────────────────────────────────────────────────────
document.getElementById('tabAdmin').addEventListener('click', async () => {
    if (!document.getElementById('usersBody').dataset.loaded) {
        await loadAdminUsers();
    }
});

async function loadAdminUsers() {
    setLoading('usersBody', 4);
    const users = await Api.getAdminUsers();
    renderUsersTable(users);
    document.getElementById('usersBody').dataset.loaded = '1';
}

function renderUsersTable(users) {
    const tbody = document.getElementById('usersBody');
    if (!users || users.length === 0) {
        tbody.innerHTML = `<tr><td colspan="4" class="no-data">Brak użytkowników</td></tr>`;
        return;
    }
    tbody.innerHTML = users.map(u => `
        <tr>
            <td>${escHtml(u.id)}</td>
            <td>${escHtml(u.username)}</td>
            <td>${escHtml(u.role)}</td>
            <td style="display:flex;gap:.5rem;padding:.5rem 1rem;">
                <button class="btn btn-secondary btn-sm"
                    data-action="changepass" data-id="${u.id}"
                    data-username="${String(u.username).replace(/"/g,'&quot;')}">Zmień hasło</button>
                <button class="btn btn-danger btn-sm"
                    data-action="delete" data-id="${u.id}">Usuń</button>
            </td>
        </tr>
    `).join('');
}

document.getElementById('usersBody').addEventListener('click', async e => {
    const btn = e.target.closest('button[data-action]');
    if (!btn) return;
    const id = parseInt(btn.dataset.id);
    if (btn.dataset.action === 'delete') {
        await deleteUser(id);
    } else if (btn.dataset.action === 'changepass') {
        openChangePassword(id, btn.dataset.username);
    }
});

async function deleteUser(id) {
    if (!confirm('Czy na pewno chcesz usunąć tego użytkownika?')) return;
    const res = await Api.deleteAdminUser(id);
    if (res && (res.ok || res.status === 204)) {
        document.getElementById('usersBody').removeAttribute('data-loaded');
        document.getElementById('changePasswordSection').classList.add('hidden');
        await loadAdminUsers();
    } else {
        alert('Błąd podczas usuwania użytkownika');
    }
}

let _changePasswordUserId = null;

function openChangePassword(id, username) {
    _changePasswordUserId = id;
    const section = document.getElementById('changePasswordSection');
    section.classList.remove('hidden');
    document.getElementById('changePasswordUsername').textContent = username;
    document.getElementById('changePasswordInput').value = '';
    section.scrollIntoView({ behavior: 'smooth' });
}

document.getElementById('confirmChangePasswordBtn').addEventListener('click', async () => {
    const password = document.getElementById('changePasswordInput').value.trim();
    if (!password) { alert('Podaj nowe hasło'); return; }
    const res = await Api.changeAdminUserPassword(_changePasswordUserId, password);
    if (res && res.ok) {
        document.getElementById('changePasswordSection').classList.add('hidden');
        _changePasswordUserId = null;
        showAlert('adminAlert', 'Hasło zostało zmienione', 'success');
    } else {
        showAlert('adminAlert', 'Błąd podczas zmiany hasła', 'error');
    }
});

document.getElementById('cancelChangePasswordBtn').addEventListener('click', () => {
    document.getElementById('changePasswordSection').classList.add('hidden');
    _changePasswordUserId = null;
});

document.getElementById('createUserBtn').addEventListener('click', async () => {
    const username = document.getElementById('newUsername').value.trim();
    const password = document.getElementById('newPassword').value.trim();
    const role     = document.getElementById('newRole').value;
    if (!username || !password) {
        showAlert('createUserAlert', 'Podaj nazwę użytkownika i hasło', 'error');
        return;
    }
    const res = await Api.createAdminUser({ username, password, role });
    if (res && res.ok) {
        document.getElementById('newUsername').value = '';
        document.getElementById('newPassword').value = '';
        document.getElementById('usersBody').removeAttribute('data-loaded');
        await loadAdminUsers();
        showAlert('createUserAlert', 'Użytkownik został dodany', 'success');
    } else {
        const text = res ? await res.text() : 'Błąd serwera';
        showAlert('createUserAlert', `Błąd: ${text}`, 'error');
    }
});
