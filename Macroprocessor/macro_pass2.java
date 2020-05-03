import java.io.*; 
import java.util.*;


public class Macropass2
{
	public static void main(String[] args) throws IOException
	{
		//Creating the output files
		BufferedReader fr_mnt = new BufferedReader(new FileReader("pass1_MNT.txt"));
		BufferedReader fr_mdt = new BufferedReader(new FileReader("pass1_MDT.txt"));
		BufferedReader fr_ala = new BufferedReader(new FileReader("pass1_ALA.txt"));
		BufferedReader objReader = new BufferedReader(new FileReader("macro_code.txt"));
		FileWriter pass2 = new FileWriter("pass2_code.txt");
		BufferedWriter p2wtr = new BufferedWriter(pass2);
		String strCurrentLine;
		
		//Making the  MDT array
		ArrayList<String> MDT = new ArrayList<String>(50);
		int first = 1;
		while ((strCurrentLine = fr_mdt.readLine()) != null) 
		{
			if(first == 1)
			{
				first = 0;
			}
			else
			{
				String[] splited = strCurrentLine.split("\t");
				MDT.add(splited[1]);
			}		
		}
		//Making the  MNT array
		ArrayList<String> MNT = new ArrayList<String>(50);
		ArrayList<Integer> MNT_int = new ArrayList<Integer>(50);
		first = 1;
		while ((strCurrentLine = fr_mnt.readLine()) != null) 
		{
			if(first == 1)
			{
				first = 0;
			}
			else
			{
				String[] splited = strCurrentLine.split("\\s+");
				MNT.add(splited[1]);
				MNT_int.add(Integer.parseInt(splited[2]));
			}		
		}
		//Making the  ALA array
		ArrayList<String> ALA = new ArrayList<String>(50);
		ArrayList<String> ALAModf = new ArrayList<String>(50);
		first = 1;
		while ((strCurrentLine = fr_ala.readLine()) != null) 
		{
			if(first == 1)
			{
				first = 0;
			}
			else
			{
				String[] splited = strCurrentLine.split("\\s+");
				ALA.add(splited[1]);
				ALAModf.add(splited[1]);
			}		
		}

		//Macro trigger
		String prev="None";
		while ((strCurrentLine = objReader.readLine()) != null) 
		{
			String[] splited = strCurrentLine.split("\\s+");
			if (MNT.contains(splited[0]) && !prev.equals("MACRO"))
			{
				//Macro Call
				int mnt_index = MNT.indexOf(splited[0]);
				int i = MNT_int.get(mnt_index);
				//Making the current macro's arg list
				for(int j =1; j<splited.length;j++)
				{
					
					//Making new ALA
					ALAModf.set(ALA.indexOf(MDT.get(i).split("\\s+")[j]),splited[j]);
				}
				i++;
				while(!MDT.get(i).equals("MEND"))
				{
					String op = MDT.get(i);
					for(int k = 0; k < ALA.size(); k++)
					{
						//Replacing formal arguments with actual arguments
						op = op.replace(ALA.get(k),ALAModf.get(k));
					}
					p2wtr.write(op);
					p2wtr.newLine();
					i++;
				}

				
			}
			else
			{
				p2wtr.write(strCurrentLine);
				p2wtr.newLine();
			}
			prev = splited[0];
			
		}

		p2wtr.close();
		
	}

}
