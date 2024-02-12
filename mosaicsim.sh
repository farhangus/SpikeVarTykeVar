#!/bin/bash

# Global variables to store amounts
SEED_TYKE=0
REFERENCE_TYKE=""
PREFIX_TYKE=""
BAM_TYKE=""
TYKE_FALG="0"
NO_COMMENT="off"
HEADERS="off"
NO_HEADER="off"
REFERENCE=""
REGIONS_FILE=""
UNCOMPRESSED="off"
NO_PG="off"
PARAMETERS=()

display_Tyke_usage() {
    echo "Options:"
    echo "  -b, --bam        <bam>         Input bam file"
    echo "  -p, --prefix     <prefix>      output prefix "
    echo "  -s, --seed       <seed>        seed number "
    echo "  -r, --reference  <REF>         reference fasta file"
    exit 1

}

# Function to display usage information for 'samtools Spike' command
display_Spike_usage() {
    echo "Options:"

}

# Function to parse options and set amounts
parse_options_tyke() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -b|--bam)
                BAM_TYKE=$2
                shift
                shift
                ;;
            -r|--reference)
                REFERENCE_TYKE=$2
                shift
                shift
                ;;
            -p|--prefix)
                PREFIX_TYKE=$2
                shift
                shift
                ;;
            -s|--seed)
                SEED_TYKE=$2
                shift
                shift
                ;;
            *)
                shift
                echo "Unknown1 option: $1"
                exit 1
                ;;
        esac
    done
}

# Main function
main() {
    # Check if any arguments are provided
    if [ $# -eq 0 ]; then
        echo "Usage: mosicsim <command> [arguments]"
        echo "Commands:"
        echo "  Tyke     Genrated simulated mosaic SV/SNV"
        echo "  Spike    Simulates a sample with potential mosiac variants at a user-specified ratio"
        exit 1
    fi

    # Parse the command and call respective function
    case $1 in
        tyke)
            shift
            if [ $# -eq 0 ]
            then
                display_Tyke_usage
                exit
            fi
            parse_options_tyke "$@"
            TYKE_FALG="1"
            ;;
        spike)
            shift
            if [ $# -eq 0 ]
            then
                display_Spike_usage
                exit
            fi
            parse_options "$@"
            ;;
        # *)
        #     echo "Unknown command: $1"
        #     echo "Available commands: Tyke, Spike"
        #     exit 1
        #     ;;
    esac
}

# Call the main function with provided arguments
main "$@"
if [ $TYKE_FALG == "1" ]
then
    echo "TykeVar pipline"
    echo "${BAM_TYKE}" "${REFERENCE_TYKE}" "${PREFIX_TYKE}" "${SEED_TYKE}"
    exit
    python3 scripts/Tyke/TykeVarSimulator/TykeVarSimulator.py "${BAM_TYKE}" "${REFERENCE_TYKE}" "${PREFIX_TYKE}" "${SEED_TYKE}"
fi 