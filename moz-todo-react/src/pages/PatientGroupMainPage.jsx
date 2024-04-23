import React, { useEffect, useState } from 'react';
import { getToken } from '../slices/tokenSlice';
import { useSelector } from 'react-redux';
import { formatToken, useCreateEmotionalSupportRequestMutation, useGetAnswersQuery, useGetUserGroupQuery } from '../slices/apiSlice';
import NavBar from '../Components/NavBar';
import RoleBox from '../Components/RoleBox';
import { nanoid } from '@reduxjs/toolkit';
import { getRole, getUserId } from '../slices/userSlice';
import AuditLog from '../Components/AuditLog';
import { useParams } from 'react-router-dom';

function PatientGroupMainPage() {  
  const token = useSelector(getToken)
  const userId = useSelector(getUserId)['payload']
  const role = useSelector(getRole)['payload']
  console.log(role)
  const { groupId } = useParams()

  const {data: answerData, isError, isFulfilled, status } = useGetAnswersQuery({token: formatToken(token['payload']), answerId: groupId})
  const {data, isSuccess, isFetching, isLoading, isUninitialized} = useGetUserGroupQuery({token: formatToken(token['payload']), groupId: groupId})
  
  const [requestEmotionalSupport, {eSupportIsSuccess, eSupportIsLoading, eSupportIsUninitialized, eSupportIsError}] = useCreateEmotionalSupportRequestMutation()
  if (typeof token == 'undefined' || token == null || !('payload' in token)){
    return <h1>404 page not found</h1>
  }
  else if (isFetching || isLoading, isUninitialized){
    return <h1>Loading</h1>
  }
  else{
    if(data && answerData){
      const rolesAndNames = data['roles'].map((person) => [person['get_user']['name'], person['role'], person['get_user']['profile_image']])
      console.log(data)
      console.log(answerData)
      
      const rolesUsed = [rolesAndNames[0][1]]
      let currentRole = rolesAndNames[0][1]
      let currentRoleGroup = []
      let out = []
      for (let i = 0; i < rolesAndNames.length; i++){
        currentRole = rolesAndNames[i][1]
        if (i === 0 || currentRole !== rolesAndNames[i - 1][1]){
          for (let j = 0; j < rolesAndNames.length; j++){
            if (rolesAndNames[j][1] === currentRole){
              currentRoleGroup.push(rolesAndNames[j])
            }
          }
        }
        
        if (currentRoleGroup.length > 0){
          out.push(<RoleBox key={nanoid()} boxes={currentRoleGroup} />)
        }
        currentRoleGroup = []
      }
      let eSupportButton = <button onClick={() => requestEmotionalSupport(formatToken(token['payload']))}>E-Support</button>
      if (role !== "	ROLE_PATIENT"){
        eSupportButton = <></>
      }
      return(<>
        <NavBar />
        <div>{out.map((box) => box)}</div>
        <div className='auditLog'>
          <AuditLog answers={answerData} />
        </div>
        {eSupportButton}
        </>)
    }
    
    
    

  }
}

export default PatientGroupMainPage;
