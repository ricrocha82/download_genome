def split_fasta(input_file, output_directory):
    with open(input_file, 'r') as fasta_file:
        sequence = None
        for line in fasta_file:
            if line.startswith('>'):
                if sequence is not None:
                    write_sequence(sequence, output_directory)
                sequence = {'header': line.strip(), 'data': ''}
            else:
                sequence['data'] += line.strip()

        if sequence is not None:
            write_sequence(sequence, output_directory)

def write_sequence(sequence, output_directory):
    header = sequence['header']
    data = sequence['data']
    seq_id = header[1:].split()[0]  # Extract sequence ID from the header
    output_file = f"{output_directory}/{seq_id}.fasta"

    with open(output_file, 'w') as out_file:
        out_file.write(f"{header}\n")
        # Write sequence data in FASTA format with line breaks every 80 characters
        for i in range(0, len(data), 80):
            out_file.write(f"{data[i:i+80]}\n")

if __name__ == '__main__':
    input_fasta_file = '/fs/project/PAS1117/ricardo/operon_tool/fasta_ecoli/U00096.3.split.fasta'
    output_directory = '/fs/project/PAS1117/ricardo/operon_tool/fasta_ecoli/splitted_fasta'  # Replace with your desired output directory
    split_fasta(input_fasta_file, output_directory)


# python -u /fs/project/PAS1117/ricardo/operon_tool/code/split_big_fasta.py
