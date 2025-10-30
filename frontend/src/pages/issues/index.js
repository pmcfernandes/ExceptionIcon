import React, { useState, useEffect, useCallback } from 'react';
import { useHistory, useParams } from 'react-router-dom';

import MainPage from '../../components/mainPage';
import IssueListItem from '../../components/issueListItem';
import auth from '../../services/auth';
import api from '../../services/api';

import NoItems from '../../assets/notfound.png';

function Issues() {
    const history = useHistory();
    const { id } = useParams();
    const [project, setProject] = useState({});
    const [data, setData] = useState([]);
    const [includeResolved, setIncludeResolved] = useState(true);

    function handleIncludeResolvedClick() {
        setIncludeResolved(includeResolved === false ? true : false);
        handleToUpdate();
    }

    function handleMarkAllResolved() {
        if (window.confirm('This feature will mark all issues in repository as resolved. Want to continue?')) {
            api.patch('/issues/markAllResolved?projectUUID=' + id).then(function (response) {
                if (response.data.__ajs && response.data.success) {
                    api.get('/issues?projectUUID=' + id + '&includeResolved=' + includeResolved.toString()).then(function (response) {
                        if (response.data.__ajs && response.data.success) {
                            setData(response.data.result);
                        }
                    });
                }
            })
        }
    }

    function handleToUpdate() {
        api.get('/issues?projectUUID=' + id + '&includeResolved=' + includeResolved.toString()).then(function (response) {
            if (response.data.__ajs && response.data.success) {
                setData(response.data.result);
            }
        });
    }

    function handleSettingsClick() {
        history.push('/projects/' + id + '/settings');
    }

    useEffect(() => {
        if (!auth.isAuthorized()) {
            history.push('/');
        }

        api.get('/projects?uuid=' + id).then(function (response) {
            if (response.data.__ajs && response.data.success) {
                setProject(response.data.result);

                api.get('/issues?projectUUID=' + id).then(function (response) {
                    if (response.data.__ajs && response.data.success) {
                        setData(response.data.result);
                    }
                });
            }
        });
    }, [history, id]);


    return (
        <MainPage>
            <div className="row mb-1">
                <div className="col-lg-9">
                    <h1>{project.name}</h1>
                </div>
                <div className="col-lg-3 text-right">
                    <i className="fa fa-cog cursor" onClick={() => handleSettingsClick()} title="Project Settings"></i>
                </div>
            </div>
            <div className="row mb-4">
                <div className="col-lg-12 text-right">
                    {(data.length === 0 ? '' : <button type="button" className="btn btn-sm btn-secondary mr-2 " onClick={() => handleMarkAllResolved()}>Mark All Resolved</button>)}
                    <button type="button" className="btn btn-sm btn-secondary" onClick={() => handleIncludeResolvedClick()}>{includeResolved === true ? 'Include Resolved' : 'Exclude Resolved'}</button>
                </div>
            </div>
            <div className="row">
                <div className="col-lg-12">
                    {
                        (data.length === 0 ?
                            <img src={NoItems} alt="No projects found." className="img-fluid" /> :
                            <table className="table">
                                <thead>
                                    <tr>
                                        <th>Count</th>
                                        <th>Last Occurred</th>
                                        <th>Exception</th>
                                        <th className="text-center">Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {
                                        data.map((item) => {
                                            return (
                                                <IssueListItem key={item.lastUUID} item={item} handleToUpdate={handleToUpdate.bind(this)} />
                                            )
                                        })
                                    }
                                </tbody>
                            </table>
                        )
                    }
                </div>
            </div>
        </MainPage>
    );
}

export default Issues;
