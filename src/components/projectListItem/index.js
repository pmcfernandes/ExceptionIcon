import React from 'react';
import { useHistory } from 'react-router-dom';
import * as timeago from 'timeago.js';

import './styles.css';

function ProjectListItem({ project }) {
    const history = useHistory();

    function handleProjectItemClick() {
        history.push('/projects/' + project.uuid + '/issues');
    }
    
    return (
        <tr onClick={() => handleProjectItemClick()}>
            <td><h4>{project.name}</h4></td>
            <td>{project.lastError}<br /><span className="date">{timeago.format(project.lastOccurred)}</span></td>
            <td className="text-center"><span className="red">{project.totalActives} of {project.total} active(s)</span></td>
        </tr>
    );
}

export default ProjectListItem;
