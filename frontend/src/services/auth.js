class auth {
    isAuthorized() {
        return !(localStorage.getItem('authorization') == null);
    };

    getAuthorizationHeader(schema) {
         if (this.isAuthorized()) {
            return schema + ' '  + this.getAuhtorization().token;
        } else {
            return '';
        }
    };

    setAuthorization(data) {
         localStorage.setItem('authorization', JSON.stringify(data));
    };

    getAuhtorization() {
        if (this.isAuthorized()) {
            return JSON.parse(localStorage.getItem('authorization'));
        } else {
            return {
                username: '',
                token: ''
            }
        }
    }

    getAuthorization() {
        return this.getAuhtorization();
    }

    logout(callBack) {
        localStorage.removeItem('authorization');
        if (typeof callBack !== 'undefined') {

            callBack();
        }
    }
}

export default (new auth());
