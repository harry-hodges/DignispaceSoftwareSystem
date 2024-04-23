import React from "react"

import Route from "./Components/Route"
import Login from "./pages/Login"
import AdminDashboard from "./pages/AdminDashboard"
import PatientGroupPage from "./pages/PatientGroupPage"
import SuspensionPage from "./pages/SuspensionPage"


export default () => {
  return (
    <div className="ui container">
      <Route path="/">
        <Login />
      </Route>
      <Route path="/admin">
        <AdminDashboard />
      </Route>
      <Route path="/adminGroups">
        <PatientGroupPage />
      </Route>
      <Route path="/suspendUsers">
        <SuspensionPage />
      </Route>
    </div>
  )
}

