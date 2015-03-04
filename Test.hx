import cpp.vm.Thread;
import cpp.vm.Gc;

class Test
{
   public static function main()
   {
      var data = new Array<Int>();
      for(i in 0...8)
         data[i] = 0;


      for(i in 0...8)
      {
         Thread.create( function() {
            var index = 0;
            var size0 = 0;
            while(true)
            {
               try
               {
                  var filename = ( (index%8) == 7) ? "junk" : "Test.hx";
                  var contents = sys.io.File.getContent("Test.hx");
                  if (index==0)
                     size0 = contents.length;
                  else if (contents.length!=size0)
                     trace("BAD SIZE !!!!\n");
                  data[i]+=contents.length;
                  var sum = 0;
                  for(j in 0...contents.length)
                     sum += contents.charCodeAt(j);
                  var junk = new Map<String,Dynamic>();
                  for(j in 0...100)
                     junk.set("key"+ j, { j : sum });
               }
               catch(e:Dynamic) {}
               index++;
            }
         });
      }

      while(true)
      {
        trace(data);
        Sys.sleep(1);
      }
   }
}