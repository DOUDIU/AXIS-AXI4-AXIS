//****************************************Copyright (c)***********************************//
//ԭ�Ӹ����߽�ѧƽ̨��www.yuanzige.com
//����֧�֣�www.openedv.com
//�Ա����̣�http://openedv.taobao.com
//��ע΢�Ź���ƽ̨΢�źţ�"����ԭ��"����ѻ�ȡZYNQ & FPGA & STM32 & LINUX���ϡ�
//��Ȩ���У�����ؾ���
//Copyright(C) ����ԭ�� 2018-2028
//All rights reserved
//----------------------------------------------------------------------------------------
// File name:           key_debounce
// Last modified Date:  2019/4/14 16:23:36
// Last Version:        V1.0
// Descriptions:        ��������
//----------------------------------------------------------------------------------------
// Created by:          ����ԭ��
// Created date:        2019/4/14 16:23:36
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
// Modified by:		    ����ԭ��
// Modified date:
// Version:
// Descriptions:
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module key_debounce(
    input        sys_clk ,
    input        sys_rst_n ,

    input        key ,         //�ⲿ����İ���ֵ
    output  reg  key_value ,   //������İ���ֵ
    output  reg  key_flag      //������İ���ֵ��Ч��־
);

//reg define
reg [19:0] cnt ;
reg        key_reg ;

//*****************************************************
//**                    main code
//*****************************************************

//����ֵ����
always @ (posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        cnt <= 20'd0;
        key_reg <= 1'b1;
    end
    else begin
        key_reg <= key;           //������ֵ�ӳ�һ��
        if(key_reg != key) begin  //�����ǰ����ֵ��ǰһ�ĵİ���ֵ��һ���������������»��ɿ�
            cnt <= 20'd100_0000;  
        end
        else begin                //�����ǰ����ֵ��ǰһ������ֵһ����������û�з����仯
            if(cnt > 20'd0)       //��������ݼ���0
                cnt <= cnt - 1'b1;  
            else
                cnt <= 20'd0;
        end
    end
end

//������������յİ���ֵ�ͳ�ȥ
always @ (posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        key_value <= 1'b1;
        key_flag  <= 1'b0;
    end
	//�ڼ������ݼ���1ʱ�ͳ�����ֵ
    else if(cnt == 20'd1) begin
		key_value <= key;
		key_flag  <= 1'b1;
        end
    else begin
		key_value <= key_value;
		key_flag  <= 1'b0;
    end
end

endmodule
