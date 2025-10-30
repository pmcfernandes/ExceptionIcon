import React, { useState, useEffect } from 'react';
import MainPage from '../../components/mainPage';
import { useHistory } from 'react-router-dom';

import auth from '../../services/auth';
import api from '../../services/api';
import './styles.css';

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

                auth.setAuthorization({
                    username: result.username,
                    token: result.uuid
                });

                if (result.username !== '') {
                    history.push('/projects');
                }

            } else {
                alert(response.data.error.message);
                setUsername('');
                setPassword('');
            }
        }).catch(function(error) {
            if (error.status === 401) {
              alert('Unauthorized\n\nIncorrect username or password.');
              setUsername('');
              setPassword('');
            } else {
              alert(error.message);
            }
        });
    }

    useEffect(() => {
        if (auth.isAuthorized()) {
            history.push('/projects');
        }
    }, [history]);

    return (
        <MainPage>
            <div id="loginPanel" className="col-lg-6 offset-lg-3">
                <div className="card">
                    <div className="card-body">
                        <h5 className="card-title">Login</h5>
                        <form>
                            <div className="form-group row">
                                <label htmlFor="email" className="col-sm-4 col-form-label">Email or Username</label>
                                <div className="col-sm-8">
                                    <input type="text" className="form-control" id="email" required placeholder="email@example.com" onChange={(e) => setUsername(e.target.value)} />
                                </div>
                            </div>
                            <div className="form-group row">
                                <label htmlFor="password" className="col-sm-4 col-form-label">Password</label>
                                <div className="col-sm-8">
                                    <input type="password" className="form-control" id="password" required onChange={(e) => setPassword(e.target.value)} />
                                </div>
                            </div>
                            <div className="form-group row">
                                <div className="col-sm-8 offset-sm-4">
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
