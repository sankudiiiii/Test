public with sharing class PM1S2Basic {
    public boolean isPrime(Integer num) {
        boolean flag = true;
        for (Integer i = 2; i < num; i++){
            if (Math.mod(num,i) == 0) {
                flag = false;
                break;
            }
        }
        return flag;
    }
    public boolean isPalindrome(String str) {
        boolean flag = true;
        for (Integer i = 0; i < str.length(); i++){
            for(Integer j = str.length() - 1; j>=0; j--){
            if (str.charAt(i) != str.charAt(j)) {
                flag = false;
                break;
            }
            }
        }
        return flag;
    }
        public String[] replace(String characterToBeReplace, String characterToReplaceWith, String[] StringArray) {
        for (Integer i = 0; i < StringArray.size(); i++)
            StringArray[i] = StringArray[i].replace(characterToBeReplace, characterToReplaceWith);
        return StringArray;
    }
    public Integer lengthOfString(String str) {
        return str.lastIndexOf('');
    }
    public list<Integer> unique(Integer[] arrayInteger){
        LIST<Integer> listInteger = new LIST<Integer>();
        Set<Integer> setInteger = new Set<Integer>();
        for(Integer i : arrayInteger){
            if(!setInteger.contains(i)){
            listInteger.add(i);
            setInteger.add(i);                
            }
            else {
                for(Integer j = listInteger.size()-1;j>=0;j--){
                    if(i==listInteger[j]){
                    listInteger.remove(j);
                    break;
                }
                }
            }
        }
        return listInteger;
    }
    
}
/*
PM1S2Basic basicObject = new PM1S2Basic();
Integer num = 17;
        if (basicObject.isPrime(num))
            System.debug(num + ' is Prime.');
        else
            System.debug(num + ' is not Prime.');
            
        String str = 'abccbA';
        if (basicObject.isPalindrome(str))
            System.debug(str + ' is Palindrome.');
        else
            System.debug(str + ' is not Palindrome.');
            
        String characterToBeReplace = 'b';
        String characterToReplaceWith = 'd';
        String [] StringArray = new List<String>();
StringArray.add('abc');
StringArray.add('aabac');
        StringArray = basicObject.replace(characterToBeReplace, characterToReplaceWith, StringArray);
        for (String str : StringArray)
            System.debug(str);
            
            String str = 'abccc';
        System.debug('Length of string ' + str + ' is ' + basicObject.lengthOfString(str));
        
        PM1S2Basic basicObject = new PM1S2Basic();
Integer [] arrayInteger = new Integer[]{1,2,3,2};
list<Integer> unique1 = basicObject.unique(arrayInteger);
for(Integer i : unique1){
System.debug(i);
}
            */