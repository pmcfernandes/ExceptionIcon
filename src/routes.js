import React from 'react';
import {BrowserRouter, Route, Switch} from 'react-router-dom';

import Login from './pages/login';
import About from './pages/about';
import Contact from './pages/contact';
import Profile from './pages/profile';
import Projects from './pages/projects';
import NewProject from './pages/addProject';
import Settings from './pages/projectSettings';
import Issues from './pages/issues';
import Issue from './pages/issue';


export default function Routes () {
    return (
        <BrowserRouter>
            <Switch>
                <Route path="/" exact component={Login} />
                <Route path="/profile" component={Profile} />
                <Route path="/about" component={About} />
                <Route path="/contact" component={Contact} />
                <Route path="/projects" exact component={Projects} />
                <Route path="/projects/add" exact component={NewProject} />
                <Route path="/projects/:id/issues" exact component={Issues} />
                <Route path="/projects/:id/settings" exact component={Settings} />
                <Route path="/projects/:id/issues/:issue" exact component={Issue} />
            </Switch>
        </BrowserRouter>
    );
}