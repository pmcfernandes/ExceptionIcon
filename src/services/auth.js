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
            return schema + ' '  + localStorage.getItem('authorization');
        } else {
            return '';
        }
    };

    setAuhtorization(id) {
        localStorage.setItem('authorization', id);
    };

    logout(callBack) {
        localStorage.removeItem('authorization');
        if (typeof callBack !== 'undefined') {
            callBack();
        }
    }
}

export default (new auth());