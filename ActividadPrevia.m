% Parámetros configurables
amplitud_sinusoidal = 1;
frecuencia_sinusoidal = 1000; % Hz
frecuencia_muestreo = 10000; % Muestras por segundo (fs)
ciclo_trabajo = 0.5; % Proporción del período de muestreo que está activa (d)

% Tiempo de simulación
tiempo_simulacion = 0.01; % 10 ms

% Crear el vector de tiempo
t = 0:1/frecuencia_muestreo:tiempo_simulacion;

% Generar la señal sinusoidal (señal original)
m = amplitud_sinusoidal * sin(2*pi*frecuencia_sinusoidal*t);

% Generar el tren de pulsos (señal portadora)
pulso = rectpuls(t - t(1), ciclo_trabajo/frecuencia_muestreo);
tren_pulsos = repmat(pulso, 1, length(t)/length(pulso));

% Visualizar las señales
figure;
subplot(2,1,1);
plot(t, m);
title('Señal Sinusoidal Original');
xlabel('Tiempo (s)');
ylabel('Amplitud');

subplot(2,1,2);
plot(t, tren_pulsos);
title('Señal Portadora (Tren de Pulsos)');
xlabel('Tiempo (s)');
ylabel('Amplitud');