import React from 'react';
import { useParams, useHistory } from 'react-router-dom';

import api from '../../services/api';

function SettingsProjectDelete() {
    const history = useHistory();
    const { id } = useParams();

    function handleDeleteClick() {
        if (window.confirm('You want delete this project? Are you sure?')) {
            api.delete('/projects?uuid=' + id).then(function(response) {
                if (response.data.__ajs && response.data.success) {
                    history.push('/projects');
                } else {
                    alert('An error is occurred, its not possible delete project at this time.');
                }
            });
        }
    }

    return (
        <div className="card mb-3">
            <div className="card-header">Delete Project</div>
            <div className="card-body">
                <p>Click the button below to delete this project.</p>
                <p>Warning! This will delete the project and all of its data, effective immediately. This action cannot be undone. Proceed with caution!</p>
                <button type="button" className="btn btn-danger" onClick={() => handleDeleteClick()}>Delete</button>
            </div>
        </div>
    );
}

export default SettingsProjectDelete;
