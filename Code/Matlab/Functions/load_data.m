function Fibers = load_data(folder,tractName,subjectNum,timesteps)

for i = 1:length(subjectNum)    
    
%     clearvars -except folder tractName subjectNum timesteps Fibers i j
    
    for j = 1:length(tractName)
        
        %The variable length, needed to reconstruct individual tracts ahs
        %the same name as the function length(). This causes issues, and
        %the code below gets around those issues. 
        
        temp = load(strcat(folder,subjectNum(i),'.',tractName(j),'.mat'),'tracts');
        tracts = temp.tracts;
        
        temp = load(strcat(folder,subjectNum(i),'.',tractName(j),'.mat'),'length');
        length1 = temp.length;
        clear temp;
        
%         load(strcat(folder,subjectNum(i),'.',tractName(j),'.mat'));        
%         length1=length;
%         clear length
        
        Fibers_temp=[];
        
        a=1;
        
        for k = 1:length(length1)
            
            Fibers_temp{k} = tracts(:,a:sum(length1(1:k)));
            
            a=sum(length1(1:k))+1;
                    
        end
        
        fibers=zeros(3,timesteps,length(Fibers_temp));
        
        parfor k = 1:length(Fibers_temp)
    
        f = Fibers_temp{k};

        fTemp=zeros(3,timesteps);

        fTemp(1,:)=interp1(0:(1/(length(f)-1)):1,f(1,:),0:(1/(timesteps-1)):1,'spline');
        fTemp(2,:)=interp1(0:(1/(length(f)-1)):1,f(2,:),0:(1/(timesteps-1)):1,'spline');
        fTemp(3,:)=interp1(0:(1/(length(f)-1)):1,f(3,:),0:(1/(timesteps-1)):1,'spline');


        fibers(:,:,k)=fTemp;
%         a=a+1

        end
        
        Fibers{i,j} = fibers;
        
        
    end

    
end

% save("C:\Users\micha\Desktop\DTMRI Project\Cleaned Data\Cingulum_Parahippocampal",'Fibers')
