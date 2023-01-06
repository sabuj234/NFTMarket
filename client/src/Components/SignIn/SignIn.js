import React, { useState } from 'react';
import { Link, Navigate } from 'react-router-dom';
import "./SignIn.css";

export default function SignIn() {

    const [formState, setFormState] = useState({
        user: null,
        error: null
    });

    const handleSubmit = async (event) => {
        event.preventDefault();
        console.log(event.target.email.value);
        try {
            let user=await event.target.email.value;
            setFormState({ user });
        } catch (error) {
            let user=event.target.email.value;
            setFormState({ user });
        }
    }

    return (
        <div>
            {formState.error && <p>{formState.error.message}</p>}
            {formState.user && (
                <Navigate to="/dashboard" replace={true} />
            )}
            <form
                onSubmit={(event) => handleSubmit(event)}
                className="signIn">
                <div className="form-outline mb-4">
                    <input name="email" type="email" value="fdasg@gmail.com" id="form1Example1" className="form-control" />
                    <label className="form-label" >Email address</label>
                </div>

                <div className="form-outline mb-4">
                    <input name='password' type="password" value={"jytdjyv"} id="form1Example2" className="form-control" />
                    <label className="form-label" >Password</label>
                </div>


                <button type="submit" className="btn btn-primary btn-block">Sign in</button>
                Don't have an account! <Link to={"/signup"}>Sign Up</Link>
            </form>
        </div>
    )
}