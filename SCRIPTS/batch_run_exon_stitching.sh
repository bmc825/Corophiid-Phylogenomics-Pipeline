#!/bin/bash

refs=("Aby_dis" "Ali_gig" "Aor_spp" "Aps_spp" "Arm_vul" "Ase_hil" "Cap_irr" "Cap_lae" "Cer_spp" "Che_zot" "Cyc_gig" "Cym_exi" "Deu_cal" "Dia_goe" "Eus_gig" "Gam_lac" "Gam_tho" "Glo_spp" "Gra_jap" "Hir_gig" "Hya_azt" "Hyp_spp" "Ido_bal" "Isc_ang" "Lat_bac" "Lep_spp" "Met_ano" "Mic_lit" "Mon_ach" "Mon_ins" "Neo_awa" "Neo_sp1" "Neo_sp2" "Nip_hra" "Orc_gri" "Par_haw" "Pho_con" "Pho_tom" "Pla_hal" "Pod_sep" "Pod_spp" "Sca_ste" "Sco_sch" "Sun_sp1" "Sun_sp2" "Tal_sal" "Tan_kom" "Tig_cal" "Tri_lae" "Zeu_ezo")

base_dir="/bwdata3/bcummings/COROPHIOID/12-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_stitching"
script_dir="/bwdata3/bcummings/SCRIPTS"
input_dir="${base_dir}/input"
ref_dir="${base_dir}/reference_db_stitching"
species_list_dir="${base_dir}/species_lists"
output_dir="${base_dir}/output"

mkdir -p "$output_dir"

for ref in "${refs[@]}"; do
    echo "🔧 Running exon stitching for $ref..."

    run_dir="${output_dir}/refseq_${ref}"
    mkdir -p "$run_dir"

    # Run from base_dir so bin/ is available; outputs go into run_dir
    bash -c "
        cd '$base_dir' && \
        bash '$script_dir/exon_stitching.sh' \
            '$species_list_dir/species_${ref}.txt' \
            '$ref_dir/refseq_${ref}.fasta' \
            '$input_dir' \
            '$output_dir/${ref}.fasta' \
            10
done
