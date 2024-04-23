import { useState } from 'react'
import '../App.css'
import { getToken } from '../slices/tokenSlice';
import { useDispatch, useSelector } from 'react-redux';
import NavBar from '../Components/NavBar';
import React from 'react';

import { formatToken, useGetAssociatedUserGroupsQuery } from '../slices/apiSlice';
import TextBox from './TextBox'
import { useNavigate } from 'react-router-dom';


function PatientGroupBox() {
    const navigate = useNavigate()
    const getIndividualPatient = () => {
      // need api setup
      return "..."
    }

    const token = useSelector(getToken)
    const {data: userGroupData, isError, isFetching: isUserGroupFetching, isLoading: isUserGroupLoading,
       isSuccess: isUserGroupSuccess, isUninitialized: isUserGroupUninitialized} = useGetAssociatedUserGroupsQuery(formatToken(token['payload']))
  
    if (typeof token === 'undefined' || token === null ||  !('payload' in token)){
      return (<h1>Page not found</h1>)
    }
    else if(isUserGroupFetching || isUserGroupLoading){
      return (<h1>Loading...</h1>)
    }
    else{
      console.log(userGroupData)
      if (userGroupData.length === 0){
        return <h1>No patient groups</h1>
      }else{
        return (
          <>
              <h1>User Group</h1>
              <div className="container" >
                  {userGroupData.map((userGroup) => (
                  <div key={userGroup.id} className ="boxStyles" onClick={() => navigate("/patientGroupMainPage/"+userGroup.user_group_id)}>
                      <h2 onClick = {getIndividualPatient}>User Group {userGroup.user_group_id}</h2>
                      <p>Roles: {userGroup.role === 'ROLE_PROFESSIONAL' ? 'Healthcare Professional' :
                                 userGroup.role === 'ROLE_PATIENT' ? 'Patient' : 'Viewer'} </p>
                  </div>
              ))}
            </div>
          </>)
    }
      }
      
}

export default PatientGroupBox
