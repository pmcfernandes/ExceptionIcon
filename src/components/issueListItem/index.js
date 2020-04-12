import React, { useState } from 'react';
import { useHistory, useParams } from 'react-router-dom';
import * as timeago from 'timeago.js';

import api from '../../services/api'
import './styles.css';

function IssueListItem({ group }) {
    const history = useHistory();
    const { id } = useParams();
    const [item, setItem] = useState(group);

    function handleIssueItemClick() {
        history.push('/projects/' + id + '/issues/' + item.lastUUID);
    }

    function handleActiveClick(e) {
        api.patch('/issues/markResolved?uuid=' + item.lastUUID).then(function (response) {
            if (response.data.__ajs && response.data.success) {
                api.get('/issues?projectUUID=' + id).then(function (response) {
                    if (response.data.__ajs && response.data.success) {
                        let item1 = response.data.result.map(item => item.lastUUID === group.lastUUID);
                        setItem(item1);
                    }
                });
            }
        });
    }

    function handleResolvedClick(e) {
        api.patch('/issues/markActive?uuid=' + item.lastUUID).then(function (response) {
            if (response.data.__ajs && response.data.success) {
                api.get('/issues?projectUUID=' + id).then(function (response) {
                    if (response.data.__ajs && response.data.success) {
                        response.data.result.forEach(function (item) {
                            let item1 = response.data.result.map(item => item.lastUUID === group.lastUUID);
                            setItem(item1);
                        })
                    }
                });
            }
        });
    }

    return (
        <tr>
            <td onClick={() => handleIssueItemClick()}>{item.total}</td>
            <td onClick={() => handleIssueItemClick()}>{timeago.format(item.lastOccurred)}</td>
            <td onClick={() => handleIssueItemClick()}><p>{item.exceptionType}</p><span>{item.message}</span></td>
            <td className="text-center">
                {
                    (item.totalActives !== 0 ? <button type="button" className="btn btn-sm btn-danger" onClick={(e) => handleActiveClick(e)} style={{ marginBottom: 5 }}>Active</button> : <button type="button" className="btn btn-sm btn-secondary" onClick={(e) => handleResolvedClick(e)} style={{ marginBottom: 5 }}>Resolved</button>)
                }
                <br />
                <span className="red" onClick={() => handleIssueItemClick()}>{item.totalActives} of {item.total} active(s)</span>
            </td>
        </tr>
    );
}

export default IssueListItem;
