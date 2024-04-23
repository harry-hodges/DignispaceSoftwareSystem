import { useEffect, useState, useRef } from 'react'
import '../App.css'
import logo from '../assets/Logo.png'
import account from '../assets/AccountImage.png'
import alert from '../assets/Alerts.png'
import pages from '../assets/MenuLines.png'
import DropdownMenuAccount from './DropdownMenuAccount'
import DropdownMenuAlerts from './DropdownMenuAlerts'
import DropdownMenuPages from './DropdownMenuPages'
import { Link } from 'react-router-dom'
import { formatToken, useGetAlertsQuery, useGetCurentUserDetailsQuery } from '../slices/apiSlice'
import { useSelector } from 'react-redux'
import { getToken } from '../slices/tokenSlice'

function NavBar(props) {

  const [openMenuAccount, setOpenMenuAccount] = useState(false)
  const [openMenuAlerts, setOpenMenuAlerts] = useState(false)
  const [openMenuPages, setOpenMenuPages] = useState(false)



  let menuRef = useRef();
  const token = useSelector(getToken)['payload']
  const {data} = useGetCurentUserDetailsQuery(formatToken(token));
  const profile_image = data['profile_image']; 

  useEffect(() => {
    let handler = (e)=>{
      if(!menuRef.current.contains(e.target)){
        setOpenMenuAccount(false);
        setOpenMenuAlerts(false);
        setOpenMenuPages(false);
      }

    };

    document.addEventListener("mousedown", handler);
  });

  return (
    <nav>
      <div className="navBar">

        <div className="title">

          <img src={logo} className="logo" />

          <h1>DIGNISPACE</h1>
          
        </div>
  
        <div className="buttons">
          
          <button className="accountButton" onClick={() => setOpenMenuAccount((prev) => !prev)}><img src={profile_image} className="account"/></button>

          <button className="alertsButton" onClick={() => setOpenMenuAlerts((prev) => !prev)}><img src={alert} className="alert" /></button>

          <button className="pagesButton" onClick={() => setOpenMenuPages((prev) => !prev)}><img src={pages} className="pages" /></button>

        </div>

      </div>

      <div className="menus" ref={menuRef}>
        {
          openMenuAccount && <DropdownMenuAccount/>
        }

        {
          openMenuAlerts && <DropdownMenuAlerts/>
        }

        {
          openMenuPages && <DropdownMenuPages/>
        }
      </div>
    </nav>


)
}

export default NavBar
