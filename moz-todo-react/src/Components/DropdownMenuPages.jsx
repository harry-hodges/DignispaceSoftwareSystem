import { useState } from 'react'
import '../App.css'
import logo from '../assets/Logo.png'
import account from '../assets/AccountImage.png'
import alert from '../assets/Alerts.png'
import { Link } from 'react-router-dom';

function DropdownMenuPages() {

  return (
    <div className="menuItemsPages">
        <ul className="menuList">
            <li><Link to="/adminGroups">Patients</Link></li>
            <li><Link to="/admin">Review Questions</Link></li>
            <li><Link to="/suspendUsers">Suspend Users</Link></li>
            <li><Link to="/manageQuestionsPage">Manage Questions</Link></li> 
            <li><Link to='/invite'>Invite Users</Link></li>
        </ul>
    </div>
  );
}

export default DropdownMenuPages