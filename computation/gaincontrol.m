function y = gaincontrol(x,alpha_param,beta_param)

% % % 
% URL to see the formula: http://mathurl.com/qdy3h49
% TeX to see the formula: 
% y_i = \frac{\alpha x_i}{\beta+\sum_{j=1}^{n}{|x_j|}} = \frac{\alpha x_i}{\beta+\|X\|_{L1}}
% % % 

x_l1norm = sum(abs(x(:)));


y = arrayfun(@(x_i) alpha_param*x_i/(beta_param+divisor), x);

% % % if max(x(:))~=0
% % %     for i = 1:8,
% % %         figure; 
% % %         subplot(1,2,1); surf(x(:,:,i)); zlim([0 0.15]); 
% % %         subplot(1,2,2); surf(y(:,:,i)); zlim([0 0.15]);
% % %     end
% % % end

return
