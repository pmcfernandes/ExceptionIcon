import React, { useState, useEffect, createRef } from 'react';
import { Link, useHistory, useParams } from 'react-router-dom';

import api from '../../services/api';

function SettingsProjectEdit() {
    const formRef = createRef();
    const { id } = useParams();
    const history = useHistory();
    const [projectName, setProjectName] = useState('');

    function handleEditClick() {
        formRef.current.addEventListener('submit', function (e) {
            e.preventDefault();
            e.stopPropagation();

            if (projectName === '') {
                if (formRef.current != null) {
                    formRef.current.classList.add('was-validated');
                }
            } else {
                api.put('/projects?uuid=' + id, {
                    'name': projectName
                }, {
                    headers: { 
                        'Content-Type': 'application/json'
                    }
                }).then(function(response) {
                    if (response.data.__ajs && response.data.success) {
                        history.push('/projects');
                    } else {
                        alert('An error is occurred, its not possible edit project at this time.');
                    }
                });
            }
        }, false);
    }

    useEffect(() => {
        api.get('/projects?uuid=' + id, null).then(function (response) {
            if (response.data.__ajs && response.data.success) {
                setProjectName(response.data.result.name);
            }
        });
    }, [id]);

    return (
        <div className="card mb-3">
            <div className="card-header">Edit Settings</div>
            <div className="card-body">
                <form id="projectEdit" ref={formRef} noValidate>
                    <div className="form-group">
                        <label htmlFor="name">Name</label>
                        <input type="email" className="form-control" id="name" required placeholder="Name" aria-describedby="nameHelp" value={projectName} onChange={(e) => setProjectName(e.target.value)} />
                        <small id="nameHelp" className="form-text text-muted">Change name of your project</small>
                    </div>
                    <div className="form-group text-right">
                        <button type="submit" className="btn btn-secondary mr-2" onClick={() => handleEditClick()}>Update Project</button>
                        <Link className="btn btn-link" to="/projects">Cancel</Link>
                    </div>
                </form>
            </div>
        </div>
    );
}

export default SettingsProjectEdit;
