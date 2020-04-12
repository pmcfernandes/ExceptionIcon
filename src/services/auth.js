class auth {
    isAuthorized() {
        if (localStorage.getItem('authorization') == null) {
            return false;
        } else {
            return true;
        }
    };

    getAuhtorizationHeader(schema) {
        if (this.isAuthorized()) {
            return schema + ' '  + this.getAuhtorization().token;
        } else {
            return '';
        }
    };

    setAuhtorization(data) {
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

    logout(callBack) {
        localStorage.removeItem('authorization');
        if (typeof callBack !== 'undefined') {

            callBack();
        }
    }
}

export default (new auth());