import React, { useState, useEffect, createRef } from 'react';
import { Link, useHistory } from 'react-router-dom';

import MainPage from '../../components/mainPage';
import auth from '../../services/auth';
import api from '../../services/api';

function AddProject() {
    const formRef = createRef();
    const history = useHistory();
    const [projectName, setProjectName] = useState('');

    function handleCreateClick() {
        formRef.current.addEventListener('submit', function (e) {
            e.preventDefault();
            e.stopPropagation();

            if (projectName === '') {
                if (formRef.current != null) {
                    formRef.current.classList.add('was-validated');
                }
            } else {
                api.post('/projects', {
                    'name': projectName
                }, {
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }).then(function (response) {
                    if (response.data.__ajs && response.data.success) {
                        history.push('/projects');
                    } else {
                        alert('An error is occurred, its not possible create project at this time.');
                    }
                });
            }
        }, false);
    }

    useEffect(() => {
        if (!auth.isAuthorized()) {
            history.push('/');
        }
    }, [history]);

    return (
        <MainPage>
            <div className="row mb-4">
                <div className="col-lg-12">
                    <h1 className="text-center">Create Project</h1>
                </div>
            </div>
            <div className="row">
                <div className="col-lg-12">
                    <form id="addProjectForm" ref={formRef} noValidate>
                        <div className="form-group">
                            <label htmlFor="name">Name</label>
                            <input type="email" className="form-control" id="name" placeholder="Name" aria-describedby="nameHelp" onChange={(e) => setProjectName(e.target.value)}  required />
                            <small id="nameHelp" className="form-text text-muted">Give a name for an project</small>
                        </div>
                        <div className="form-group text-right">
                            <button type="submit" className="btn btn-secondary mr-2" onClick={() => handleCreateClick()}>Create Project</button>
                            <Link className="btn btn-link" to="/projects">Cancel</Link>
                        </div>
                    </form>
                </div>
            </div>
        </MainPage>
    );
}

export default AddProject;
