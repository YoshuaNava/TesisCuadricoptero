function u = PID(error, error_integral, error_previo)
    %Fuente de gran parte del codigo: http://www.mathworks.com/matlabcentral/answers/30176-mimoi-ss2tf-how-to-apply-input-to-tf
    Kp = [1, 0, 0, 0, 0, 0; 0, 1, 0, 0, 0, 0; 0, 0, 1, 0, 0, 0; 0, 0, 0, 0.0, 0, 0; 0, 0, 0, 0, 0.0, 0; 0, 0, 0, 0, 0, 0.0];
    Ki = [0.0, 0, 0, 0, 0, 0; 0, 0.0, 0, 0, 0, 0; 0, 0, 0.0, 0, 0, 0; 0, 0, 0, 0.0, 0, 0; 0, 0, 0, 0, 0.0, 0; 0, 0, 0, 0, 0, 0.0];
    Kd = [0.0, 0, 0, 0, 0, 0; 0, 0.0, 0, 0, 0, 0; 0, 0, 0.0, 0, 0, 0; 0, 0, 0, 0.0, 0, 0; 0, 0, 0, 0, 0.0, 0; 0, 0, 0, 0, 0, 0.0];

    u = Kp*error + Ki*error_integral + Kd*(error-error_previo);
end