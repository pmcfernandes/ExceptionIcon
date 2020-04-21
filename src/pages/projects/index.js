import React, { useState, useEffect } from 'react';
import { Link, useHistory } from 'react-router-dom';

import MainPage from '../../components/mainPage';
import ProjectListItem from '../../components/projectListItem';
import auth from '../../services/auth';
import api from '../../services/api';

import NoItems from '../../assets/notfound.png';

function Projects() {
    const history = useHistory();
    const [data, setData] = useState([]);

    useEffect(() => {
        if (!auth.isAuthorized()) {
            history.push('/');
        }

        api.get('/projects').then(function(response) {
            if (response.data.__ajs && response.data.success) {
                setData(response.data.result);
            }
        });
    }, [history]);

    return (
        <MainPage>
            <div className="row mb-4">
                <div className="col-lg-6">
                    <h1>Projects</h1>
                </div>
                <div className="col-lg-6 text-right">
                    <Link className="btn btn-secondary" to="/projects/add">Add Project</Link>
                </div>
            </div>
            <div className="row">
                <div className="col-lg-12">
                    {  
                        (data.length === 0 ? 
                            <img src={NoItems} alt="No projectts fouded." className="img-fluid" /> : 
                        <div>
                            <table className="table">
                                <thead>
                                    <tr>
                                        <th>&nbsp;</th>
                                        <th>Last Error</th>
                                        <th style={{ width: 160 }} className="text-center">Frequency</th>
                                    </tr>
                                </thead>
                                <tbody>
                                {
                                    data.map(p => {
                                        return (
                                            <ProjectListItem key={p.uuid} project={p} />
                                        )
                                    })
                                }
                                </tbody>
                            </table>
                        </div> 
                    )}
                </div>
            </div>
        </MainPage>
    );
}

export default Projects;
