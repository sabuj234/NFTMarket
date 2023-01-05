import React from "react";
import SignIn from "../src/Components/SignIn/SignIn";
import {
  createBrowserRouter,
  RouterProvider,
} from "react-router-dom";
import SignUp from "./Components/SignUp/SignUp";
import Dashboard from "./Components/Dashboard/Dashboard";

export default function App(){
  const router = createBrowserRouter([
    {
      path: "/",
      element: <SignIn/>,
    },
    {
      path:"/signup",
      element:<SignUp/>,
    },
    {
      path:"/dashboard",
      element:<Dashboard/>,
    }
  ]);
  return (
  <div className="m-1">
    <RouterProvider router={router}/>
  </div>
  )
}