import { useState } from 'react';
import '../App.css'
import { formatCreateQuestion, formatToken, useCreateQuestionMutation } from '../slices/apiSlice';

function AuditLog({ answers }) {
    const allAnswers = answers.map( (answer) => [answer['get_question']['title'], answer['audit_logs'], answer['created_at']])
    console.log(allAnswers)
    // adds when questions are answered
    let auditLogs = allAnswers.map( (answer) => [answer[0], "Question answered", answer[2]])

    allAnswers.map( (answer) => {
        if (answer[1].length > 0){
            answer[1].map( (auditLog) => {
                auditLogs.push([answer[0], auditLog['action'], auditLog['created_at']])
            })
        }
    })

    console.log(auditLogs)

    // sort answers
    const sortedAuditLog = auditLogs.sort((log1, log2) => {
        let date1 = new Date(log1[2])
        let date2 = new Date(log2[2])

        if (date1 < date2)
            return 1;
        if (date1 > date2)
            return -1;
   
        return 0;
    })
    console.log(sortedAuditLog)
    const auditLogOutput = sortedAuditLog.map( (auditLog) => {
        let date = new Date(auditLog[2])
        return(
            <>
                <h2>Title: {auditLog[0]}</h2>
                <p>{auditLog[1]}</p>
                <p>{date.toLocaleString()}</p>
            </>
        )
    })
    
    if(answers.length > 0){
        return (
            <>
              <h1>Audit Log</h1>  
              <div>
                {auditLogOutput}
              </div>
            </>
        );
    }else{
        return (<>
            <h1>Audit Log</h1>  
            <h2> No answers released</h2>
            </>)
    }
    
}

export default AuditLog