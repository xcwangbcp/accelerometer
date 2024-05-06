function [ output_args ] = get_battery_volt_nrf_CR_battery( input_args )
% *16 : because i make adc_value >>4 in the nrf program
% reference the program : #define ADC_RESULT_IN_MILLI_VOLTS(ADC_VALUE) ((((ADC_VALUE) * ADC_REF_VOLTAGE_IN_MILLIVOLTS) / ADC_RES_12BIT) * ADC_PRE_SCALING_COMPENSATION)
% *4/3: because i use lipo-battery, and use a voltage divider of 3/4

output_args=input_args*16/4096*0.6*6;


end
