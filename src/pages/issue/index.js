import React, { useState, useEffect } from 'react';
import { useHistory, useParams } from 'react-router-dom';
import * as timeago from 'timeago.js';

import MainPage from '../../components/mainPage';
import IssueDetail from '../../components/issueDetail';
import auth from '../../services/auth';
import api from '../../services/api';

import './styles.css';

function Issue() {
  const history = useHistory();
  const { issue } = useParams();
  const [data, setData] = useState({});

  function handleActiveClick(e) {
    api.patch('/issues/markResolved?uuid=' + issue).then(function (response) {
        if (response.data.__ajs && response.data.success) {
            api.get('/issues?uuid=' + issue).then(function (response) {
              if (response.data.__ajs && response.data.success) {
                setData(response.data.result);
              }
            });
        }
    });
}

function handleResolvedClick(e) {
    api.patch('/issues/markActive?uuid=' + issue).then(function (response) {
        if (response.data.__ajs && response.data.success) {
            api.get('/issues?uuid=' + issue).then(function (response) {
              if (response.data.__ajs && response.data.success) {
                setData(response.data.result);
              }
            });
        }
    });
}

  useEffect(() => {
    if (!auth.isAuthorized()) {
      history.push('/');
    }

    api.get('/issues?uuid=' + issue).then(function (response) {
      if (response.data.__ajs && response.data.success) {
        setData(response.data.result);
      }
    });
  }, [history, issue]);

  return (
    <MainPage>
      <div className="row">
        <div className="col-lg-9">
          <p className="projectName">{data.projectName}</p>
          <h3>{data.exceptionType}</h3>
          <p className="date">{timeago.format(data.dateOccurred)} at {(data.dateOccurred || '').substring(0, 16).replace('T', ' ')}</p>
        </div>
        <div className="col-lg-3 text-right">
          { (
            data.isResolved === false ? 
              <button type="button" className="btn btn-danger" onClick={(e) =>handleActiveClick(e) }>Active</button> :
              <button type="button" className="btn btn-secondary" onClick={(e) =>handleResolvedClick(e) }>Resolved</button>
            )
          }
        </div>
        <div className="col-lg-12">
          <IssueDetail issue={data} />
        </div>
      </div>
    </MainPage>
  );
}

export default Issue;
