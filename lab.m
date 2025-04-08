fc = 1000;
t = (0:1e-05:5/1000)';
y = sin(2*pi*fc*t);  % Señal Moduladora
% Muestreo natural
fs = input('Ingrese la frecuencia de muestreo fs: \n');  
nt = 0.5 * square(2 * pi * fs * t) + 0.5;

ws = y .* nt;
ws1 = ws;

% Graficar señal original y PAM muestreo natural
figure
subplot(3,1,1); plot(t, y); title('Señal Original'); xlabel('Tiempo'); ylabel('Amplitud');
subplot(3,1,2); plot(t, ws1); title('PAM Muestreo Natural'); xlabel('Tiempo'); ylabel('Amplitud');

% Muestreo instantáneo
for i = 2:length(t)
    if nt(i) == 1 && nt(i-1) == 0
        ws(i) = nt(i) * y(i);
    elseif nt(i) == 1 && nt(i-1) == 1
        ws(i) = ws(i-1);
    else
        ws(i) = 0;
    end
end

subplot(3,1,3); plot(t, ws); title('PAM Muestreo Instantáneo'); xlabel('Tiempo'); ylabel('Amplitud');

figure
plot(t, y, 'r', t, ws1, 'g', t, ws, 'b');
title('Señal Original y PAM'); xlabel('Tiempo'); ylabel('Amplitud');
% Fourier
figure
z2 = fft(y);
subplot(3,1,1); plot(t, abs(z2)); title('Fourier Señal Original'); xlabel('Tiempo'); ylabel('Amplitud');

z1 = fft(ws);
subplot(3,1,2); plot(t, abs(z1)); title('Fourier PAM Muestreo Natural'); xlabel('Tiempo'); ylabel('Amplitud');

z3 = fft(ws);
subplot(3,1,3); plot(t, abs(z3)); title('Fourier PAM Muestreo Instantáneo'); xlabel('Tiempo'); ylabel('Amplitud');

% PCM
N = input('Número de bits: \n');
bits = 2^N;
paso = (max(y) - min(y)) / bits; % Tamaño del paso de cuantificación
cuantificado = round(y/paso) * paso;  % Señal cuantificada

% Error de cuantificación
error = ws - cuantificado;  % Error entre la señal PAM y la cuantificada
error2 = y - cuantificado;


% Graficar la señal cuantificada y el error de cuantificación
figure
subplot(3,1,1); plot(t, y); title('Señal Original'); xlabel('Tiempo'); ylabel('Amplitud');
subplot(3,1,2); plot(t, ws); title('PAM Instantáneo'); xlabel('Tiempo'); ylabel('Amplitud');
subplot(3,1,3); plot(t, cuantificado); title('Señal PCM'); xlabel('Tiempo'); ylabel('Amplitud');


figure
plot(t, y, 'r', t, ws, 'g', t, cuantificado, 'b');
title('Señal PCM'); xlabel('Tiempo'); ylabel('Amplitud');

figure
subplot(3,1,1); plot(t, error); title('Error PAM Instantáneo y PCM'); xlabel('Tiempo'); ylabel('Amplitud');

subplot(3,1,2); plot(t, error2); title('Error Señal Original y PCM'); xlabel('Tiempo'); ylabel('Amplitud');
