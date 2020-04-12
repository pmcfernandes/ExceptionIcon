import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';

import api from '../../services/api';
import './styles.css';

function SettingsProjectAPI() {
    const { id } = useParams();
    const [key, setKey] = useState();

    function handleResetClick() {
        api.patch('/projects/generateKey?uuid=' + id).then(function (response) {
            if (response.data.__ajs && response.data.success) {
                setKey(response.data.result.apiKey);
            }
        });
    }

    useEffect(() => {
        api.get('/projects?uuid=' + id).then(function (response) {
            if (response.data.__ajs && response.data.success) {
                setKey(response.data.result.apiKey);
            }
        });
    }, [id])

    return (
        <div className="card mb-3">
            <div className="card-header">API Key</div>
            <div className="card-body">
                <p>The following API key should be used when configuring Excepticon exception reporting for this project:</p>
                <div className="row">
                    <div className="col-lg-12">
                        <code><span>Api-Key:</span> {key}</code>    
                        <hr />
                    </div>
                </div>
                <p>Resetting your API key will cause exception reporting for any applications or services still using your old key to stop working, effective immediately.</p>
                <button type="button" className="btn btn-danger" onClick={() => handleResetClick()}>Reset API Key</button>
            </div>
        </div>
    );
}

export default SettingsProjectAPI;
