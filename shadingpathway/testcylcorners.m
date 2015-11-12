function [pixelArray] = testcylcorners(folder)


narginchk(1,1)
%get file list in a folder


listing = dir(fullfile(folder,'*.png'));


if numel(listing) > 0
    for ind = 1:numel(listing),
        img_in = im2double(imread(fullfile(folder, listing(ind).name)));
        if size(img_in,3) > 1, img_in(:,:,2:3) = []; end
        imshow(img_in); hold on;
        crn = corner(img_in);
        plot(crn(:,1),crn(:,2),'r*');
        pause(0.05); hold off;
        if(size(crn,1))>2
            rec = fit_rectangle (crn);
            vertices = rec.bounding_points;
            line([vertices(1,1), vertices(2,1)],[vertices(1,2),vertices(2,2)])
            line([vertices(2,1),vertices(3,1)],[vertices(2,2), vertices(3,2)])
            line([vertices(3,1),vertices(4,1)],[vertices(3,2), vertices(4,2)])
            line([vertices(4,1),vertices(1,1)],[vertices(4,2), vertices(1,2)])
            line([vertices(1,1),vertices(3,1)],[vertices(1,2), vertices(3,2)])
            line([vertices(4,1),vertices(2,1)],[vertices(4,2), vertices(2,2)])
        end
    end
end

return