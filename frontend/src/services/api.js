import axios from 'axios';
import auth from './auth';

const api = axios.create({
    baseURL: 'http://localhost:44345/api',
    timeout: 3000,
    responseType: 'json',
    // Do not set Authorization statically here because token can change during runtime.
    // We'll set the header dynamically using a request interceptor below.
    validateStatus: function (status) {
        // Accept any 2xx as successful; many APIs return 201/204 etc.
        return status >= 200 && status < 300;
    }
})

// Add request interceptor to always attach the latest Authorization header.
api.interceptors.request.use(function (config) {
    try {
        const authHeader = auth.getAuthorizationHeader('Bearer');
        if (authHeader) {
            config.headers = config.headers || {};
            config.headers['Authorization'] = authHeader;
        }
    } catch (e) {
        // If auth access fails (e.g., localStorage unavailable), continue without header.
    }

    return config;
}, function (error) {
    return Promise.reject(error);
});
// Response interceptor to handle global errors (e.g., 401 Unauthorized)
api.interceptors.response.use(function (response) {
    // Any status code that lie within the range of 2xx cause this function to trigger
    return response;
}, function (error) {
    // If there's no response (network error), just reject
    if (!error || !error.response) return Promise.reject(error);

    var status = error.response.status;

    // Handle 401 Unauthorized globally: clear auth and redirect to login/home
    if (status === 401) {
        try {
            // Clear local auth state
            auth.logout();
        } catch (e) {
            // ignore logout errors
        }

        // Avoid infinite redirect loops: if we're already on the login page, don't force navigation
        try {
            var currentPath = window && window.location && window.location.pathname ? window.location.pathname : null;
            if (currentPath !== '/') {
                // Use full navigation to ensure the app resets
                window.location = '/';
                // short-circuit further handling
                return Promise.reject(error);
            }
        } catch (e) {
            // If window isn't available or access throws, just reject
        }
    }

    return Promise.reject(error);
});

export default api;
