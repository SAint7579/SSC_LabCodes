import java.io.*; 
import java.util.*;


public class macro_pass1
{
	public static void main(String[] args) throws IOException
	{
		//Creating the output files
		FileWriter fw_mnt_f = new FileWriter("pass1_MNT.txt");
		BufferedWriter fw_mnt = new BufferedWriter(fw_mnt_f);
		fw_mnt.write("Index\tName\tMDT Index");
		fw_mnt.newLine();
		int mnt_index=0;

		FileWriter fw_mdt_f = new FileWriter("pass1_MDT.txt");
		BufferedWriter fw_mdt = new BufferedWriter(fw_mdt_f);
		fw_mdt.write("Index\tName");
		fw_mdt.newLine();
		int mdt_index=0;

		FileWriter fw_ala_f = new FileWriter("pass1_ALA.txt");
		BufferedWriter fw_ala = new BufferedWriter(fw_ala_f);
		fw_ala.write("Index\tName");
		fw_ala.newLine();
		int ala_index=0;
		BufferedReader objReader = new BufferedReader(new FileReader("macro_code.txt"));
		String strCurrentLine;
	

		//Macro trigger
		int ismacro = 0;
		while ((strCurrentLine = objReader.readLine()) != null) 
		{
			String[] splited = strCurrentLine.split("\\s+");
			if (splited[0].equals("MACRO"))
			{
				//The name is yet to be stored
				ismacro = 2;
				continue;
			}
			if (ismacro==2)
			{
				//Trigger to MDT status
				ismacro = 1;
				//Storing the name in MNT
				fw_mnt.write(mnt_index + "\t" + splited[0] + "\t" + mdt_index);
				fw_mnt.newLine();
				mnt_index++;
				//Storing the variables in ALA
				int len = splited.length;
				String argument;
				for( int i =1; i<len;i++)
				{
					argument = splited[i];
					fw_ala.write(ala_index + "\t" + argument);
					fw_ala.newLine();
					ala_index++;
				}
			}
			
			if(ismacro == 1)
			{
				//Storing in MDT
				fw_mdt.write(mdt_index + "\t" + strCurrentLine);
				fw_mdt.newLine();
				mdt_index++;			
			}

			if(splited[0].equals("MEND"))
			{
				ismacro = 0;
			}
			
		}

		fw_mnt.close();
		fw_mdt.close();
		fw_ala.close();
		
	}

}
