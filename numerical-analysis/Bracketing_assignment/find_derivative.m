clear all; close all;
syms v Isc io v vt

f = Isc + io.*(1-((v/vt)+1).*exp(v/vt));
slope_f = diff(f)