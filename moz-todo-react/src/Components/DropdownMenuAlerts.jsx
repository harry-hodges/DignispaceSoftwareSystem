import { useEffect, useState } from 'react'
import '../App.css'
import logo from '../assets/Logo.png'
import account from '../assets/AccountImage.png'
import alert from '../assets/Alerts.png'
import { useSelector } from 'react-redux'
import { getToken } from '../slices/tokenSlice'
import { formatToken, useGetAlertsQuery } from '../slices/apiSlice'
import { nanoid } from '@reduxjs/toolkit'

function DropdownMenuAlerts() {
  const token = useSelector(getToken)['payload']
  const {data, isLoading, isUninitialized, isSuccess} = useGetAlertsQuery(formatToken(token))
  const [hidden, setHidden] = useState()
  const [firstApiCall, setFirstApiCall] = useState(true)

  let topics = []
  if (data){
    topics = data.map(((alert, index) => [alert['topic'], (alert['high_priority'] == true ? "high priority" : "low priority"),
    convertTimeFormat(alert['created_at']), alert['description'], alert['web_link'], index]))

    if (firstApiCall){
      setHidden(Array(topics.length).fill(true))
      console.log(hidden)
      setFirstApiCall(false)
    }
  }
  
  if (isLoading || isUninitialized){
    return (
      <div className="menuItemsAlerts">
          <ul className="menuList">Loading</ul>
      </div>
    );
  }else if (topics.length === 0){
    return (
      <div className="menuItemsAlerts">
          <ul className="menuList">No alerts</ul>
      </div>
    );
  }else{
    return (
      <div className="menuItemsAlerts">
          <ul className="menuList">
            {topics.map(((topic) => {console.log(topic); return (
              <li key={nanoid()} onClick={(() => changeHiddenIndex(topic[5]))}>
                <b><span>{topic[0] + "   |   " + topic[1]}</span></b>
                <div style={{height:40}} className={(hidden == null ? "side" : !hidden[topic[5]]? "upside" : "side")}><svg class="arrows">
							<path class="a3" d="M0 40 L30 72 L60 40"></path>
						</svg></div>
                <ul key={nanoid()} hidden={(hidden == null ? true : hidden[topic[5]])}>
                  <li key={nanoid()}>{topic[3]}</li>
                  <li key={nanoid()}>{topic[2]}</li>
                  {topic[4] == null ? <></> : <p><a key={nanoid()} className="normalLink" href={topic[4]}>Goto Page</a></p>}
                </ul>
              </li>
            )}))}
          </ul>
      </div>
    );
  }

  function changeHiddenIndex(index){
    let newHidden = [...hidden]
    newHidden[index] = !(hidden[index])
    setHidden(newHidden)
  }

  function convertTimeFormat(time){
      let date = new Date(time)
      return date.toLocaleString()
  
  }
  
}

export default DropdownMenuAlerts