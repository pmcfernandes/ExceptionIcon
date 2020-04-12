import React, { useState, useEffect } from 'react';
import MainPage from '../../components/mainPage';
import { useHistory } from 'react-router-dom';
import auth from '../../services/auth';
import api from '../../services/api';

function Login() {
    const history = useHistory();
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');

    function handleLoginClick(e) {
        api.post('/login', {
            'Username': username,
            'Password': password
        }).then(function(response) {
            if (response.data.__ajs && response.data.success) {
                let result = response.data.result;
                console.log(result);

                sessionStorage.setItem('username', result.username);
                console.log(result.username);
                auth.setAuhtorization(result.uuid);
                history.push('/projects');
            } else {
                alert(response.data.error.message);
                setUsername('');
                setPassword('');
            }
        }).catch(function(error) {
            alert(error);
        });
    }

    useEffect(() => {
        if (auth.isAuthorized()) {
            history.push('/projects');
        }
    }, [history]);

    return (
        <MainPage>
            <div className="col-lg-6 offset-lg-3">
                <div className="card">
                    <div className="card-body">
                        <h5 className="card-title">Login</h5>
                        <form>
                            <div className="form-group row">
                                <label htmlFor="email" className="col-sm-3 col-form-label">Email</label>
                                <div className="col-sm-9">
                                    <input type="text" className="form-control" id="email" required placeholder="email@example.com" onChange={(e) => setUsername(e.target.value)} />
                                </div>
                            </div>
                            <div className="form-group row">
                                <label htmlFor="password" className="col-sm-3 col-form-label">Password</label>
                                <div className="col-sm-9">
                                    <input type="password" className="form-control" id="password" required onChange={(e) => setPassword(e.target.value)} />
                                </div>
                            </div>
                            <div className="form-group row">
                                <div className="col-sm-9 offset-sm-3">
                                    <button type="button" className="btn btn-primary" onClick={(e) => handleLoginClick(e)}>Login</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </MainPage>
    );
}

export default Login;
