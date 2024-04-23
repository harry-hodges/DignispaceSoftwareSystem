import { useState } from 'react'
import '../App.css'
import logo from '../assets/Logo.png'
import account from '../assets/AccountImage.png'
import alert from '../assets/Alerts.png'
import { Link } from 'react-router-dom';
import { formatToken, useLogoutMutation } from '../slices/apiSlice'
import { getToken } from '../slices/tokenSlice'
import { useSelector } from 'react-redux';

function DropdownMenuAccount() {
  
  const token = useSelector(getToken)['payload']
  const [logout] = useLogoutMutation()
  return (
    <div className="menuItemsAccount">
        <ul className="menuList">
            <li><Link to="/profile">Profile</Link></li>
            <li><Link to="/preferences">Settings</Link></li>
            <li><Link to="/" onClick={(() => logout(formatToken(token)))}>Logout</Link></li>
        </ul>
    </div>
  );
}

export default DropdownMenuAccount
