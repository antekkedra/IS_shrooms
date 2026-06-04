const Auth = {
    TOKEN_KEY: 'shroomsToken',
    USER_KEY:  'shroomsUser',

    getToken()  { return localStorage.getItem(this.TOKEN_KEY); },
    setToken(t) { localStorage.setItem(this.TOKEN_KEY, t); },

    getUser()   {
        const raw = localStorage.getItem(this.USER_KEY);
        return raw ? JSON.parse(raw) : null;
    },
    setUser(u)  { localStorage.setItem(this.USER_KEY, JSON.stringify(u)); },

    isLoggedIn() { return !!this.getToken(); },
    isAdmin()    { const u = this.getUser(); return u && u.role === 'ROLE_ADMIN'; },

    logout() {
        localStorage.removeItem(this.TOKEN_KEY);
        localStorage.removeItem(this.USER_KEY);
        window.location.href = '/index.html';
    },

    requireAuth() {
        if (!this.isLoggedIn()) window.location.href = '/index.html';
    },

    headers() {
        return { 'Content-Type': 'application/json', 'Authorization': `Bearer ${this.getToken()}` };
    }
};
