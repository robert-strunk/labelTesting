public with sharing class DynamicVFController {

    public String jsonStr {get;set;}

    public DynamicVFController() {

        Map<String, String> labelMap = new Map<String, String>();
        String labelStr = ApexPages.currentPage().getParameters().get('labels');

        if(NULL != labelStr){

            labelStr = labelStr.trim();
            
            List<String> labelNames = new List<String>{labelStr};

            if(labelStr.contains(',')){
                labelNames = labelStr.split(',');
            }

            for(String labelName : labelNames){
                try{
                    Component.Apex.OutputText cmp = new Component.Apex.OutputText();
                    cmp.expressions.value = '{!$label.' + labelName + '}';
                    String labelval = String.valueOf(cmp.value);
                    labelMap.put(labelName, labelval);
                }
                catch(Exception e){
                    System.debug(LoggingLevel.ERROR, 'Invalid Label API Name \"' + labelName + '\"');
                }
            }
        }
        jsonStr = JSON.serialize(labelMap);
    }
}