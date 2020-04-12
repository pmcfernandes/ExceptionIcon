import React from 'react';
import { Link, useHistory } from 'react-router-dom';

import auth from '../../services/auth';
import './styles.css';

function Header() {
    const history = useHistory();

    function handleLogoutClick() {
        if (auth.isAuthorized()) {
            auth.logout(() => {
                history.push('/');
            })
        }
    }

    function getUsername() {
        return sessionStorage.getItem('username');
    }

    return (
        <nav className="navbar navbar-expand-lg navbar-dark bg-dark">
            <div className="container">
                <Link className="navbar-brand" to="/projects">ExceptionIcon</Link>
                <button className="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span className="navbar-toggler-icon"></span>
                </button>

                <div className="collapse navbar-collapse mr-auto" id="navbarSupportedContent">
                    <ul className="navbar-nav mr-auto">
                        <li className="nav-item active">
                            <Link className="nav-link" to="/projects">Projects <span className="sr-only">(current)</span></Link>
                        </li>
                        <li className="nav-item">
                            <Link className="nav-link" to="/about">About</Link>
                        </li>
                        <li className="nav-item">
                            <Link className="nav-link" to="/contact">Contact</Link>
                        </li>
                    </ul>
                    <ul className="navbar-nav mr-0">
                        <li className="dropdown">
                            <Link className="nav-link dropdown-toggle" to="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">{getUsername()}</Link>
                            <div className="dropdown-menu" aria-labelledby="navbarDropdown">
                                <Link className="dropdown-item" to="/profile">Profile</Link>
                                <div className="dropdown-divider"></div>
                                <Link className="dropdown-item" to="#" onClick={() => handleLogoutClick()}>Logout</Link>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    );
}

export default Header;
