import React, { useState, useEffect } from 'react';
import { Link, useHistory, useParams } from 'react-router-dom';

import MainPage from '../../components/mainPage';
import ProjectAPI from '../../components/settingsProjectAPI'
import ProjectEdit from '../../components/settingsProjectEdit'
import ProjectDelete from '../../components/settingsProjectDelete'
import auth from '../../services/auth';
import api from '../../services/api';

function Settings() {
    const [data, setData] = useState({});
    const history = useHistory();
    const { id } = useParams();

    useEffect(() => {
        if (!auth.isAuthorized()) {
            history.push('/');
        }

        window.$('#v-pills-tab a').on('click', function (e) {
            e.preventDefault();

            window.$('#v-pills-tabContent')
                .find('.tab-pane')
                .removeClass('show')
                .removeClass('active');

            window.$('#v-pills-tabContent')
                .find('#' + this.id.replace('-tab', ''))
                .addClass('show')
                .addClass('active');
        });

        api.get('/projects?uuid=' + id).then(function (response) {
            if (response.data.__ajs && response.data.success) {
                setData(response.data.result);
            }
        });
    }, [history, id]);

    return (
        <MainPage>
            <div className="row mb-4">
                <div className="col-lg-12">
                    <h3>{data.name}</h3>
                </div>
            </div>
            <div className="row">
                <div className="col-lg-3">
                    <div className="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                        <Link className="nav-link active" id="gettingstarted-tab" data-toggle="pill" role="tab" aria-controls="v-pills-home" aria-selected="true" to="#gettingstarted">Getting Started</Link>
                        <Link className="nav-link" id="api-tab" data-toggle="pill" role="tab" aria-controls="v-pills-profile" aria-selected="false" to="#api">API Key</Link>
                        <Link className="nav-link" id="edit-tab" data-toggle="pill" role="tab" aria-controls="v-pills-messages" aria-selected="false" to="#edit">Edit</Link>
                        <Link className="nav-link" id="delete-tab" data-toggle="pill" role="tab" aria-controls="v-pills-settings" aria-selected="false" to="#delete">Delete</Link>
                    </div>
                </div>
                <div className="col-lg-9">
                    <div className="tab-content" id="v-pills-tabContent">
                        <div className="tab-pane fade show active" id="gettingstarted" role="tabpanel" aria-labelledby="gettingstarted-tab">
                            <p>For many project types, adding Excepticon error monitoring can be accomplished in just a couple of simple steps.</p>
                            <h3>Install the Excepticon Nuget Package</h3>
                            <p>Install the latest version of the Excepticon package via the Nuget Package Manager, the Package Manager Console, or the dotnet CLI.</p>
                            <pre>
                               &gt; Install-Package ExceptionIcon
                            </pre>
                            <h3>Initialize the ExcepticonSdk</h3>
                            <p>Initialize the ExcepticonSdk with your project's API Key:</p>
                            <pre>
                                <span>static void Main(string[] args)</span><br />
                                <span style={{ marginLeft: 15 }}>using (ExcepticonSdk.Init("Your ApiKey Here"))</span><br />
                                <span style={{ marginLeft: 30 }}>throw new ApplicationException("My test exception.");</span>
                            </pre>
                            <p>Unhandled exceptions within the using block will automatically be sent to Excepticon.</p>
                        </div>
                        <div className="tab-pane fade" id="api" role="tabpanel" aria-labelledby="api-tab">
                            <ProjectAPI />
                        </div>
                        <div className="tab-pane fade" id="edit" role="tabpanel" aria-labelledby="edit-tab">
                            <ProjectEdit />
                        </div>
                        <div className="tab-pane fade" id="delete" role="tabpanel" aria-labelledby="delete-tab">
                            <ProjectDelete />
                        </div>
                    </div>
                </div>
            </div>
        </MainPage>
    );
}

export default Settings;
