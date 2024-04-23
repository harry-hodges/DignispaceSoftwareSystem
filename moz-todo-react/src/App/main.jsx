import React from 'react'
import ReactDOM from 'react-dom/client'

import { Provider } from 'react-redux';
import { store } from './store.js';

import { BrowserRouter, RouterProvider, createBrowserRouter, redirect } from 'react-router-dom';
import Login from '../pages/Login.jsx';
import AdminDashboard from '../pages/AdminDashboard.jsx';
import SuspensionPage from '../pages/SuspensionPage.jsx';
import PatientGroupPage from '../pages/PatientGroupPage.jsx';
import Dashboard from '../pages/Dashboard.jsx';
import ProfileDetails from '../Components/ProfileDetails.jsx';
import ManageQuestionsPage from '../pages/ManageQuestionsPage.jsx';
import PatientGroupMainPage from '../pages/PatientGroupMainPage.jsx';
import InviteUsersPage from '../pages/InviteUsersPage.jsx';
import ManageQuestionsForProffesionalPage from '../pages/ManageQuestionsForProffesionalPage.jsx';
import ResetPasswordPage from '../pages/ResetPasswordPage.jsx';
import PreferencesPage from '../pages/PreferencesPage.jsx';
import ForgotPassword from '../pages/ForgotPasswordPage.jsx';

const router = createBrowserRouter([
    {
        path: "/",
        element: <Login />,
    },
    {
        path: "/admin",
        element: <AdminDashboard />
    },
    {
        path: "/suspendUsers",
        element: <SuspensionPage />
    },
    {
        path: "/adminGroups", // need to change name 
        element: <PatientGroupPage />
    },
    {
        path: "/profile",
        element: <ProfileDetails />
    },
    {
        path: "/dashboard",
        element: <Dashboard />
    },
    {
        path: "/manageQuestionsPage",
        element: (<ManageQuestionsPage />)
    },
    {
        path: "/manageQuestionsPageForProf",
        element: (<ManageQuestionsForProffesionalPage />)
    },
    {
        path: "/patientGroupMainPage/:groupId",
        element: <PatientGroupMainPage/>
    },
    {
        path: "/invite",
        element: <InviteUsersPage />
    },
    {
        path: "/resetPassword",
        element: <ResetPasswordPage />
    },
    {
        path: "/preferences",
        element: <PreferencesPage />
    },
    {
        path: "/forgotPassword",
        element: <ForgotPassword />
    },

    
    
]);

ReactDOM.createRoot(document.getElementById('root')).render(
    <Provider store={store}>
        <RouterProvider router={router} />
    </Provider>
)
