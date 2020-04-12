import axios from 'axios';
import auth from './auth';

const api = axios.create({
    baseURL: 'http://localhost:44345/api',
    timeout: 3000,
    responseType: 'json',
    headers: {
        'Authorization': auth.getAuhtorizationHeader('Bearer')
    },
    validateStatus: function (status) {
        return status === 200;
    }
})

export default api;