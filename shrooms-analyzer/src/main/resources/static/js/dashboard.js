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

document.getElementById('analyzeFamilyBtn').addEventListener('click', async () => {
    const family = document.getElementById('analyzeFamily').value.trim();
    if (!family) return;
    const result = document.getElementById('familyResult');
    result.classList.add('hidden');

    const dto = await Api.analyzeFamily(family);
    if (!dto) { result.innerHTML = '<div class="alert alert-error">Nie znaleziono danych dla podanej rodziny.</div>'; result.classList.remove('hidden'); return; }

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
let _occurrenceData = [];
let _phChart = null, _moistureChart = null, _carbonChart = null;

document.getElementById('tabAnalysis').addEventListener('click', async () => {
    if (!document.getElementById('speciesSelector').dataset.loaded) {
        await loadCharts();
    }
});

async function loadCharts() {
    _occurrenceData = await Api.getOccurrenceData();
    const selector = document.getElementById('speciesSelector');
    const families = [...new Set(_occurrenceData.map(d => d.family).filter(Boolean))].sort();
    selector.innerHTML = '<option value="">Wszystkie rodziny</option>' +
        families.map(f => `<option value="${f}">${escHtml(f)}</option>`).join('');
    selector.dataset.loaded = '1';
    renderCharts('');
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

// Histogram: oś X = wartości parametru glebowego (biny), oś Y = liczba wystąpień w każdym binie
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

document.getElementById('exportAnalysisBtn').addEventListener('click', () => Api.exportXml('analysis'));
