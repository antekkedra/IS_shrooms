const BASE = '/api';

async function request(url, options = {}) {
    const res = await fetch(BASE + url, { headers: Auth.headers(), ...options });
    if (res.status === 401) { Auth.logout(); return null; }
    return res;
}

const Api = {
    async login(username, password) {
        const res = await fetch(`${BASE}/auth/login`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ username, password })
        });
        if (!res.ok) throw new Error('Nieprawidłowa nazwa użytkownika lub hasło');
        return res.text();
    },

    async getMe() {
        const res = await request('/user/me');
        return res ? res.json() : null;
    },

    async getFungi() {
        const res = await request('/fungi');
        return res ? res.json() : [];
    },

    async searchFungi(species) {
        const res = await request(`/fungi/species/${encodeURIComponent(species)}`);
        return res ? res.json() : [];
    },

    async getSoil() {
        const res = await request('/soil');
        return res ? res.json() : [];
    },

    async getAnalysis() {
        const res = await request('/analysis');
        return res ? res.json() : [];
    },

    async analyzeFamily(family) {
        const res = await request(`/analysis/family/${encodeURIComponent(family)}`);
        if (!res || !res.ok) return null;
        return res.json();
    },

    async exportXml(resource) {
        const res = await fetch(`${BASE}/export/${resource}`, {
            headers: { ...Auth.headers(), 'Accept': 'application/xml' }
        });
        if (res.status === 401) { Auth.logout(); return; }
        if (!res.ok) { alert('Błąd eksportu'); return; }
        const xml  = await res.text();
        const blob = new Blob([xml], { type: 'application/xml' });
        const url  = URL.createObjectURL(blob);
        const a    = Object.assign(document.createElement('a'), { href: url, download: `${resource}.xml` });
        a.click();
        URL.revokeObjectURL(url);
    }
};
