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
document.getElementById('tabAnalysis').addEventListener('click', async () => {
    if (document.getElementById('analysisBody').dataset.loaded) return;
    setLoading('analysisBody', 5);
    const data = await Api.getAnalysis();
    const rows = (data || []).map(a => ({
        id:          a.id,
        species:     a.fungiOccurrence?.species,
        family:      a.fungiOccurrence?.family,
        correlation: a.correlationValue?.toFixed(4),
        createdAt:   a.createdAt ? new Date(a.createdAt).toLocaleDateString('pl-PL') : null
    }));
    renderTable('analysisBody', rows);
    document.getElementById('analysisBody').dataset.loaded = '1';
});

document.getElementById('exportAnalysisBtn').addEventListener('click', () => Api.exportXml('analysis'));
