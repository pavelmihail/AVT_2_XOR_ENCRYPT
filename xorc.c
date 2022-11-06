#include <stdio.h>

main()
{
   FILE *fp;
   FILE *fpe;
   char buff[1024];
   int buffSize = 0;
   const int key = 0x0F;
   int i = 0;

//file encryption
   fp = fopen("tema.txt", "r");
   fgets(buff, 1024, (FILE *)fp);

   for (i = 0; i <= 1024; i++)
   {
      if(buff[i] == NULL)
      break;
      buff[i] = buff[i] ^ key;
      buffSize++;
   }

   printf("%s\n", buff);

   fclose(fp);

//write the encrypted buffer in encryption.txt
   fpe = fopen("encryption.txt", "a");
   fprintf(fpe, buff);
   fclose(fpe);

//file decription
   fp = fopen("temaOut.txt", "w");

   for (i = 0; i <= buffSize; i++)
      {
         buff[i] = buff[i] ^ key;
      }
   
   printf("%s\n", buff);
   fputs(buff, fp);
   fclose(fp);

   return 0;
}