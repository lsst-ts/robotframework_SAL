*** Settings ***
Documentation    AtScheduler_target communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atScheduler
${component}    target
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_log

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage :  input parameters...

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Logger.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_log
    ${output}=    Read Until    logger ready =
    Log    ${output}
    Should Contain    ${output}    Event ${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 370936585 914535767 PHHvWLnFDwbgCRuzGzPgLwjPYCaqFZGjQqUcOYggEmtgLJgqnPrLhdZwPsUjYsmaISPvNSJFKmYwOjkxMnkmbvfVmAGAzPDZyxivWkwrdfBvnxHZkBYkpNqZpStFbbvHeBlczojylBTnMdAWYXQvuWJOlhJqNKupGQfqLrJRHOsagPqnUpSASDanxRqHJIImKgnATBVzHngwsuepLRuMQUMhTfFboDoPcTHwgJkdpZAaOhkLzEqmwBTmjsgbhSxaPoKgGVAcwFuNuDnkyYkuuuylGdqZUrGcgsdlEuaMcBdynYbBEzILoJKmIOZReThiuMxAFPMVWcFHNjBJUSkfLUFhhrEMRmETfcHCNPmfJMYJyuNjYkwRvGVZhcMGPVAsVpWsfqLptonnJzaxJsTkdcDjhoFOGMpfuZANuQKEqlouYhEMNttwUhHzXBSaaQDbQWDhAzhJhrhNpYYKIhVVIAkUlLwxraWplSqkPnjoEEqUfUIMMnltGDgTNJrDiqvOjPTmWTMQeaDhLCJAUzkjjqJtaVSELJvUTGuXwHzkjYZbZjiQdgnpMGACYgqzOtSDTuwwZAzTzMbDjLIWEnUoncCemvogoOjOloWnjOptUeIUKOPfWSZgMPoepupPDWbXqSjCaMZzWKByKsGKNLfXyeOfRtBkEuUYquYKnsnkkAZWDvYwYIxsezSgZcyWKHRBazjHDySLKKInaIUHpxCznbUaWpNaxqtRoRewxhudoDUhyFxWccAkdBLnpDlEhzdlRRBPrXxpFlVsxwrppNTeXVsOTWzhzUTwIrdlVoWCxPMwxqbRuxMhyyaPYlGCnyKNEWklwfiRCxWczhkvrVCtNdUTVzxFQHLjZFwVHhdkhCfUgXjzmcGtaPQNStrNfuBGwsUYHrBgPMqaUFRmdeIczp MsixeGKUjWxYRARUeXlFkHvocdtjztgTUriUTjkHUSlIhmYDYndMmPUcwguiGvvErkbUvTItSZPcfELByhcXQDWXZhafjMSdhLqlUGhgFglyZpADryzZvhdCCMqNiKskkHelCDzVOfqIvdaEniIhEhRZZicPQVHRDevIAzQJIozybqipOlZjcVGrddPMxRhwYxKJPtUJzypXwOoeHegWSczmwVOKlHMizwBGGUPpukrqqhxLAVZfayFOcoTkKQPLptcfAApgFeuneQbGSDraknbAKbmRDnOizxONJsojcpZkcrndujgyiJAzXecAqGPqarnkaAIVAkpsligoFPsjlviyIFElpGuiDzaFGbwkDfCjXmDJApGESbpfiNpdLneganKzdatfEPRWWGnETucQvPTIgZHlktOBhvpqkHELQrlcIjIXUguQBIyLhcJYCMVlIMzMUWozEjIGOXiHwkyznQORGngCBCsUvZHoAbxxbYJBFIrdMRnOgfRNxILOZBuyqTkRWuZckazXRudrnkMNdegBjxbaOxGwoBirTMsh OjWDarRaUiFWtEdcKMhiBtniNTYqqprGSYZXHpASYBRcbLjuTigWDFcdWEDmKEInSUKmrMtmopVHRHmdnUKouuFqCnyWlDWpkFxErgZfYtrpZkfVEhJwBmpwyNuxjKEbiZxwJaMCoDAKqgblVEdKeyvNCxWavyRpSrsCSWdKyrqPCLqdqkkXrtmckCV SRlbjrlaVthAacFixgUdLURGFaZoMappYtADlEhYJLjgyVhzMMDDdZhrYkhqpZPKTKOByRqkTrrgjcuikZYITlPHmZdVzIDFIqSqFoGEPNhLIOXxkBBSgzOrgTAoNuVriTyOtCFOHIwKPjbvlqTFGwdfEyeecNHLpxNEhJwByRIKLrghCBTwnZdKnJjpTSmCzdrgsxVbFxPeomylqZPGEnNncdOdapBUXmhVYatCUblprgAvvaQFAuhWLnfeJWAPCuhCUosuncRINyBrMHftpdPHDHLqMffueHhayOpvUraGinkuhqRkLjuxuUjvxJAqfyvchTnRDHtGdbsipfuZnFIRAiwRbMzySwwGSLKMLdyObpTzYzBQanOXlEMdCVgJSCWumTXzXzizFKUFLhDwnXbaldokrSqNWVLehTEhHLPSPScYwLkdheBaGGAumzWBlKiaELuKQQIDMDlnWwoGTHPwucJUZBtQjMzCcZLVjFzbMBGtVYHGWioQzUqXSmRbohJRJSuErcBUTBBVnxAIgXWlFdQrWeYGgSvyxzqGKpGxNGYRHodyfxHGrhqNlMFreCoYYRUvncAEMXuKdnkoXDPGvGhioOXZgeYJpDlaVfOjHOxEusDmOSjxWyEoZhIFWVnUYNjqXzbXhbcKCxsmymxZEqQYMjvRxnQkSXrPmFZFZACrLhhsxMzKWngSPXsEWBcsSQnvyODkjhsoWXZRczhAINTRkwEonYjKRFmiOWJuWfnjvZwiSbfRknYeluzQhGLtVrNJjtPLNDrIqFEOVMExIBZmYXKDurtSkKPtHuLCwafivZBjjvQWfDRzGYgKcFFlJvaBQlzGtQHKXfSUAVXdekAexYwfNyjyxbBvqdlbjoycIUQsgETiSpy PSrHgpWqqBfZiuXlUAhmFbLldprwvDgjShkpUcgNNzPFHNQEnNSBocEdmeXlTyjlklMYBAuUwWyZotEDbjTflLopEfFqWIlXKrUZogdhaPCTdmhupJyxqyRVtgJpzgkpsYzWmRhlKzjhOwxYBYQIUCOLfexWaQBCTAzoyTIENJwMRQlBQKDHlMTcfQeWIKPRzyRJIMGwyctlIGEZOyQeCYaTBOTmgMsSRGojtxVYTHvOzvbfKbOkXCbwevsxPkoPiMVvONxGHSJxeebOZbpXdnAvxTRdQjojvOseqnrKCTBbTLFOTSfrUUKoMqUxCAxkSlGEyCkahPLVaKpUVkIRlylQksYGKWdQwgkEySiwMaJbTHWykQMuZaYtIQDCjZPDVWWJmdnLOWqUVLZdSsATWBqudkBlDdpAUkdgoILgaRQzFXVCtXPFFocYmAIOirHztjlwUYInHVxgJzBAjEHxAhCyjkEczOmNEoOPaOxQjgctdkMecIuCDmVOYcbqAjxHqMRUuiJtpVbZED vmlEjUJzginPjehlzsHxmZwhUJNZWlaSmBTHTstBDyrWZnFYnowXtWtsVHlNAxfrqhidWVxlfSKiqGjGDloWRZwPCUStTiNkAJRPYdKAlHBHpudYjxIHAeFAfGjqfSLFZppUIDqVAyOjvjuXULPuePJnEpLMweuc jQeHngOJyRgcVYRCojKcazwpHBPcSlOJLJlQQdfADVmOFRMYgxNEpUCWqHWsrJrfBqeTRGoVkBtAxMCeYQZVQZSNlokBTLDSPflewtqbfPgBOxcBxdLcDcPaQOhFgSTemqhkahrnCXwDqfdtsgDpdGWOfQjNCIBWpVHVEsmPQOpgiQDPcizGFezuTxaXOcIDqDyOEnpGGpBrQBiDEydfItVctBYTwEAlINpPKdGhGyVrGQTnsjMQKzaATqKQCxjwSkwLWJeNFtBqpEpmPEysipKSbroKNRmcZzIkjFayPgbprhlizGYEaEiNkRwHWKcwzVcDvBpzzAUPnNkbgVuabyfQFADhXdWWrWYHJbdChzZSDWVWjZGPHGCvANPlpuVFojKMoMHaVEuRdqMRKNqTyUmEQuLCxYFVEtTWwqXictljyalakQQabSxVgMgjkGTUSsZJpvUanroUPOfeYIoZfcckprEBKtNWJXHSWZvTJpYalQFBuwCPsQhEqfBlyhHjIRTJZtjpcZrGFRMrmZoJWRrzAnKNzRBHKeueiIEynXkEqFoXpVpwrvCdfywqsrxnmNmTwxOnoNjzsefwfQJqgNwsfBHOUDzIoHgSJSwRFoEeUZfIrhrDybszzQoibDtklcUszTWRsePVFpRdiQeJtXnnzOYBvkyUlwUuVfRDVcNHSmXuoAbDBxdoneGYOikjpcpVOYXzbXClEuhlSuQusarHRyUBYDsgtIxbmFOCDEdnhnoWNSmeecCiwJWlXeVPplBEkAivQEtMnAhmxsIZAinekJh wFeEuRVJCPLujRnLtwXgqioagXoDWEPNsyIOVLCYWejYwPjudIIeKWnOjvlztJKtKIjIgkDutfLqvJxABQlqMtUNSCQncYfNYTMqFPLKMikYARfeqdNMSUQwNFnmuToXkfRcselsIwoEvjAULHRoXtlAufWEXWYyirUNLvxjiRExZcTExuCuirBBhsziKfCZtjBBiaqNchmWYExOFuuSCTiIQATTbaKredPlKYFntYjDpoFKqouocUrtOUNKujiHjTQNfbRHDqbMvYqRtGyvoXOuGEaxGYzdGUMvCrofFGGkvCBKuweTXEQOvbQWzZQFqBzvZITUkjlUaYVPXgNQvqSwgrvpcJqANEjZRDdJuzAnyaaJsJNRHYmhHMrZDMNJbIFWYhIvspCKUPankfBbeEqcCSwwHtZlVFQcOdsTzzKsS MhLOIbnulNvuBlaruVWvDULbIwlXbbxiutjgnQNUXyoUzgUnTRGmXXWHDniyifLS NWOPddkoCHvjvRVyTnPBCXTVwblJjotVhIVhKuhXpUanJAqjYzzavWVKebxvrPEmNSZPOxzatxbkofxqvRhdzSkNByjSFkjVEKXzOnPlyliLizGBQgvOxGXTjbBANLWXprnyxJIBYoGrEhmtsvhiGvmugQfjLkpcyCmYivFiJZfgBYdniBFjbeLqZKDHpwJgniQSlgBwdoBWCmHiPDnaHmgDTgmcSnnmkWAVbTuTGayyrmIzKwypREobthzKwuCczkkOdMNsPFaFAGnXOWDUJrPnsUaNHRKGoTnZKmLIFwQQgwyetTreXnTNQHiTQXfQSgXhKvFKMdilhpzQruACBKhACLRiTvmBZhneEPHjmTMhWsFwrVlehIfVqczpcnzDNuilyKYoMUGiAasVAzrjvuEyThylxeVJhzucFiFOvGXMOhPjEXEppzBfPSHvPKgmNJtjNTrEuEpQncpWUrSicclhuTkxSoMDUAjwJSEErWrxGocoFZepwDqRZpsDyHnWIHfEphuWfiariijxucJYtZcceDviPHiBVpqMLWcevKVfrtLYLWzYlDemsEoUxSzBbkquZYFwJJeNHhFPfzwVEreQjBklkVDheTZGXNtDOsfbEPogPHgADJvDyqKDzfyPfTHRZEszwynVZiTiuEnELRXsZhhcghjeLGXdJigpXgLmoIVxMJLxcJLxqW qHsSLCDALYzhKeAXpraEasfomyZmYJVgMzFHRcsgytdnACrqXFLRbaLzITHCzfHikfTVCzdyuulycfjeNcMJMCIRrSCFnOlvRFaAoSZKxnvHgNBEDDJllVrnsIIqZlIzAkoqMZXnPikeboDyephmrpjCNcKVGdQOSONWAeziafuRPgALNHBYIzHHsccpfGBvskisIWAaRccBxQkXUZjRWCodzircWbPYPaXiArpqLtsSVIcgaqiDCYBSFykCNjuSNbtWzIHVGpjoXDiyMOzDXpSsODwUorLxrvXZvuclWTNdAaZtwGoTeeITQojJAMchcEMSGylwUsmAbWiHjfbBdfRSXPHbLEhNVmNHxarmJyPBgUTcKixKNXDRUsrkianUlHgSzDvyVuWtixSoHlgqRCNSdsRmcEuoWqFssxUIEFCigpichKHrebczfIIoRYTzNCjsyNXnDAmIJPxHYnihkydGoJYrIoFnteyXqpgHCYcDfylmXMwvyZkMKMbELVZXUnwyFzXaObOxahjcqknNUHoHEAqlCDMXeRYinvgFicsEoVTWNVcGQAgelSwxUxNcWNJRmokuwJNXNALUDYMojdLskrVamPtITeYLgumEeOFEKUIFfXZfWKCXLbzMpuCsuVEGWdRJTGkfSjqJeGcEVCBoiKyjcbayzIytEghfvVVirmbaVltrMvsbKTuOxRDXJNETSvNDaAhAccxgpeRmRVMZtiWGWHNHmlCSwuCxJGczCNlkdlfmpIwyhZOsJbqDFwZLmJEzgUjSSVLKysTPXrXmxRarTPlMugWcVOcjBfNPsDIXDHlGJvxCnUzuJhlxBzQBMLijublWNouBHgwJqFDdsqdaoQJFwcAqegUoxvlzTgHpOXhGaWULMWjqOrCoGIFkhXbGbdVmFRTqAmgXZDTZgOGcsfciCRQSxCObFnuipfeeQP MVuPlHsXVmPByEVkJJQErSxldxMZfZSvpnZomqyXfFgwlAheFPzEhRTBpWvwiFXDoTtvsivALpipwwBOyXWkEHBvFimJvdkSEfTvZAkdwXjXimNFcWhuiPUdPVzzPwQnAtEHXBbQMSKrbBdhlJVPyZpLtiBPoGiYqAmIDPAlHsNxwqrUaljuitHTMrgLFyCqyAocUEBVopdjvccFoesjaOjzZauALOXoFzVZXzYbSkYXQMtbMTKjHBWjWWVhdnOZfCNxuDgOdcICExbdtOVwAzSazcjNiDDyGLAtbVlVOOWeAvfzReqdLmuesHNhtYQlevNTAVidrDFlfMcQSdrMIDkePcfsIxYXXUPcpvKlkOfxGAzxhorYSfnZwPzkoZjKSWxUOVDaWhzBCxqulLOBVyGGHPAVjPITVrqBjHnQWFgGlJgcsIopHeWYWEccuCgqlnGyKkwlRDYTYsEpTmqSOcaXhTuXasTTBttddAMaNQGWPgPMrHxduDxHVJsyMwZHjsNnXkriFxPsmZRnJuFjnfpCeLejewHyIGVujfbYLTdqulnWKqkosZoyyqasHGNoonNI izaRekbMDPAaUZqPOqmvjBhqiOwLIZsulUpXpOVeafAkWcATRpJtzFlbNvwsxLYuAlPoSsscpnDwcOpNzEFSzzmqnrFLNrPmETYJHCEZbeFIQnuKNDDHyWobQYqshufwEmbROEAnzMSnxALnPvQDsJsqxcHwozwEDBPMUnobHyQGKXKmlbMnBGsDkjWEgyMDfCWfEjyDHGQFHKwsvBrYYbP HqJNmpkWBIFfviUAcTQRCaZoFPdeuUvBLAIKBLyFxDPPQjNCCiZnEmIzUqAKBQSgLwepinxpLPPvWMwITnKEzSKwiWltzcGLkPFdHeKRqbeiLlBHsLEDjLVoXTZfxnpVEyIClHcswivUBzBLnnaubAKnNNwpZmvPdWFKygKAuXLspPTUgsGbhWlMYTSSMEdxZumUYYGGdbxvCCVbbQOotjknGWdddRGBJUcqcQeGkBRtwucrlBQjdrKzFlmRiwSKjxvsRthdpweCBZIyfrQIdCplmZAUxTELhyvutLkaqpyOvNVUJJfNjzEFpRmlhIXjKqHOsCMEPUEQNBcRoTCpjdhGkKrGynHRHLvNnzufgBVuGQQXgIFIwIazntZioMKkrBmHnMzTxvdfAFotTbVVFjQSvFFxgVcXmYWAaqMznGxcZgoNvgXCAingSmtJqnkyhfcXsDKDSwNeYKYhYOnpggSzTVFoBuIsRJhfmncAcQVXzRGqcWWpzyyngHbvgzXTytsPvXMcpHRGsaOobMRdpXZVEHmsGRfFqfxqDLuiiszTQbzaaXrVrFmfWSUvkRVKsjJbtVzkWsrNsRlNRQaEyVKflKwXIlNlXTXMVhVWmBjLlcdXzhqerVbkqCkuZmjdAvaPsexaZNknjGZrWIDyKjmUfxfqwunbmmPUPBikBpzQfDyPHZGWlpuyTGzrcKNjtobewDuQvaRvAkfNAyezpMzIUdHtNTniYKaYThSEclNzegRBMuRLuBlWqtkYXwCODsIqjdqbLRLpQuZBRbwvQkWNZXzrfoesAxAuVUWtXfpZUZJUUqtqBSvCXxVJanaPQTQEpjIziIYQmqDRh DFTfSDhCOFxViztlZtJGnAkqbcWtdfMKIUrEOeKGnNajwOLoSfMMZDoXZqsSVnvbNftvuYnPURevcWmRSvUbaNJVFdLohFRaezdKIcPBkhZrSaRaDtxwvDabQxLFacodDeGoifbzftbnCLQpHHPALeGVyDmBcXHATbxnEfpxuWFgyKuQfyGEdMgczCTUfPaHMfMIHPlukZNrWbNTyiIzQXFzPUdgnFrGkdcJuRvAMFEgJrybazQVqftMiaztnvLqKnYlhJXQyDKCSpmjqBZlXMhFJKReSXBGsUbUMlJaqIcwkUUioZsFNzptJwCIrHwbBhowvzfiNffQTKWIpQgyAmCaoawsXNLiuQhCNEykoPlAHZcsuCRyyZrITSUcpvwfnbPADCxENpgkKMFxktEQmkGFkGaPjIHHhykcZqugAXWYGLUkFgwyvnFjCMMzvxeJpdUPgfFeUqieXYiZsrErQkLPPnQSgNXRxfNN NQUtriRcNGPHJltDAPxvrodkonLRdBoOTHHFbKVVazRiWTCesMytXeKyGgXSRmiIDXHakCkAAHUcfkxIgWbkaqEcXKXrFykYEkWijmHAeyKwcySqonBjgZwSvDwHTLoVmPMyfDglHKoKQAYzdtmYcSYqiGAAeXoSgLLgnzKPWmPzOUCbJUBWvNfDVoYVaTBOlhPEntggbGPmguESZaIzzUyNDdbjtzkKWMKdFsstwkKhIatkZwXPEtpznSRNvcNSWfoKVxuIdvqCSxtGVOFedkYBScIqYbMGwfoyuRjItsZyQgsMkGKERMljyRWpidqFxeFRmLgxQTOFSNqVjwcFbgbDuWiQZu RkXyaPiYmkjNDudZMfVnoexQOfKqNplfAhKPrNofaBtjGUwCUcURPUfgxkbCWSgNsoUohgZHzeWmtKbDnrBZWtmkznyfLewndYIDEpIFdSaieqNhibfdnmWPXmJSKjoECoTBkoENLtrGqEpEseeooOzxEnOBZunvxNqrfRfehJIHJkdvVxPVeeWRHQbTrWoBUpVkcFcpgyvyTQHNGmDuTKynDNsaaKxPIshOcIugoWPhdOcsJhYKBJZDqwITIhpHjGjBJERVVmtvYPmkjhASstUdAfKVGzQIdxQjcEtOpFaOwhbAmZoMLThLSZYzRpnhBUxIJbkyHZbFPsfOCnslzrBxkkRBEsnHrjHNouncCBKzYOSfhINfiwrbIqtDTTfJovjeQfXyxzlJNDRJBxqStSccLBAnjpnoWbeMPfKZMlzumfwcPNHTJUroXwUxUjLsQykmviuxcaFgqgfKWkeNMJkNNegVgoawKCSBFABjiJMsptoMkhEOwukLIhfjZPltPLZGJCDeETxGooCsagaaLhAONKfLpouhmbngFmtyQfkONLmpraeqKOUSMWxavHiDCJvgJltlAHhFTzHninKjWiryFNENsVixuosImicTIqoPwUGeuKNcULpqQTZYmBgABTQPdgfkalDuoqTvXCMdyGxMIhSuVnfkfYpMvKAdTJZZtyisTgMWtDijImrqmyPIczGuuulmkpnhlVHhYFsqDcqDGVgffmsFdPfZWvXPOFUFailKYmxOKnOkfeyZChuoZHXLHuEjXLOMxxHGHunipnaGEbcuzyxExLVvYxLacMYMAOjfrYPltDIltfvqMwDkPksjaXnzbkuJwjVOPMlJdLOioPHjHGzBNOTLDBNiWFNzbhVlRMzFGevBvEBaJloPofKdBaPJSJobuvcLSHyhjWaRSQeYrEYpZKUVasexqUBurgWIZOZVEdCYxkWViqUVYTlBOEtQxVyZspLRceFltjBDH CAEUiRbhGehiKnCMugmNUnRZXInWNtZvqhUbVbzZRNIapTbxjexbGiPAnMaErUANtZglqWTzCFKfyJwwBOznTWSdBBjftDxopyLEEuIvNsaykwZbZNiuHXrwTubBjgZqyINUsSyAAsZFPkQXeZboUdvJNmnjJxPhJzAsqxtNYdnmLCnNDisqWwpcgFyczDYNvkcbKAhhpDDwXyrijieGLSmyGNOnPiMQZzYrmldAgKapCZPkSyAtoWYMooWMhrFYgwfSBHtyFpOGEJeVKWIfgvtOGeVCBFPPEuHTWLRmIdYAXxXfHMuXDLiULsurlBHjJkJYVpkIrWHXOvlTNvnITUbAOGpuNitBBCYlkvAzycqJIokeiPxIRbCfWhrvyfTmbEDAsrRgEzQhibJteuDlbklAebbpEbckAFkiqrEqaREjDWALHvGrmSNfPmKyoDOWPWgznJsIMfsOOLlZKekNtviXcqbnTkJXZcXRhXQutVJRlGlMFfirdtlmzSYfWbpFynVesNBpedAiHFEZnlCZGzoYBakzuaWKYQQDpyHiXBeyzNwAVBWwifiyPxAsxvOHDRofjqWFIdOkMAdKHOgykAztAaNuqKatlgceuAhMEKW KcOzEQiXlVlcOshxBsLwKFuBZANSRWQPqqqsKcRmQrVlAMaJMMIMCuyeHupndZoBSHeZjfFoaDzCjaIRnJadHNjwidPGITgUTrGcitVufxDjPcDjwlDZqHSvuaKDLDdwlyiytbTydwFLootrrtTOKoESwBbTwJcFkVbFxnXfNTvqzECpnMvqwbxPwwGpqJoEiWtOdCnvIFRzdhUNQnXEOhKVthszGjylWQKmDyhiSklWpKqcMgKJFCxkgzHpEa lXChDvBtaABUwCYLwnlBovKTkYZSvodlFclDdCcGrweMazFwamZmwUXnPiLToVROlytMpaASgiTHQqawjCtXtEMRwMLiAvyvMNTJkhdolysXluwHbRxvzCpegQbvhiDgPMGbcbWHakTZZpDzbNHqvDCdEdoPESDRSCJOpUyiYbAhHTcgSUGXjaLPEJQwmhcIGEqJwlMODWhXcBVzjQeRYPmnOluSIgpWukShYSloZHfhZtegczjJRPYxLcsMGVsxqiayOgKmyILYSukviRZFeSjLrHzMDZePgJaknBKrEEmqrjsjphhwkyyTyCEeSdZtpuhRInHJEdWEYndnbyiOAXUeunWEFkabNlYSpRhUeaoUgMgDnMUJtYbRUpYzxEGCujijgVdmWTxWBwummMWDLHSxqebMllyyAFsDhwfdjAterqRMcUSSNCVODOqyrbMjIYKRzthPhsKAJzqfUCQqiBbbeYcoWblMpdSLmFUGDhWSxvOVNzIqQSAVsgXMasMzQDnprwAPLDeiMbhiHurzDcRTvsFoXMUXDbPesqtHFUVhawmCnLpTxNSnugEeafoNncWauGYhQUtoedvntsWQkARugcMocyuNVpkoexRHNAMxwSRoHDqgtrXJhJsInDEBLrrjEfHTMeGnzkWTUwhBbOvaMFCSzrjdXwNFrIbiyLbOToXaSgTELvOfrayRhvenEIFXtrcWOCbfqPGhaXENffkyBfBjwTncCeNBxqRhljYzhWNTKuSFJKotKZgYFlzwevwNnSMBMSPigKAsYgTvLKAaWrtfgWZhTmALHKEbaKCWysbwmsjGlQrRrqYOVYcWRjfPNPIXWalRgGpRlxeTVJsxrpaslHiiIMoVPrAiUKRakqhYqdlehDus 75.5293 3.5486 44.4247 61.4067 46.8406 -1925259569 -841145258 105512890 -136194398 -2127285882 -1387613391 1302993542 232677382 -438972379 267118016 -562474517 5.7234 11.3223 15.2448 58.7147 63.719 0.574235 0.390259 0.900037 0.486456 0.929491 0.599827 0.310994 0.846337 0.113875 0.100363 0.162044 0.112837 0.684575 0.565768 0.597364 0.587433 0.407693 0.186006 0.288818 0.917933 0.939869 0.859214 0.916711 0.536546 0.665739 0.988172 0.621065 0.984298 0.921499 0.153731 2041152334
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atScheduler::logevent_target writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event target generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 2041152334
    Log    ${output}
    Should Contain X Times    ${output}    === Event target received =     1
    Should Contain    ${output}    targetId : 370936585
    Should Contain    ${output}    fieldId : 914535767
    Should Contain    ${output}    filters : PHHvWLnFDwbgCRuzGzPgLwjPYCaqFZGjQqUcOYggEmtgLJgqnPrLhdZwPsUjYsmaISPvNSJFKmYwOjkxMnkmbvfVmAGAzPDZyxivWkwrdfBvnxHZkBYkpNqZpStFbbvHeBlczojylBTnMdAWYXQvuWJOlhJqNKupGQfqLrJRHOsagPqnUpSASDanxRqHJIImKgnATBVzHngwsuepLRuMQUMhTfFboDoPcTHwgJkdpZAaOhkLzEqmwBTmjsgbhSxaPoKgGVAcwFuNuDnkyYkuuuylGdqZUrGcgsdlEuaMcBdynYbBEzILoJKmIOZReThiuMxAFPMVWcFHNjBJUSkfLUFhhrEMRmETfcHCNPmfJMYJyuNjYkwRvGVZhcMGPVAsVpWsfqLptonnJzaxJsTkdcDjhoFOGMpfuZANuQKEqlouYhEMNttwUhHzXBSaaQDbQWDhAzhJhrhNpYYKIhVVIAkUlLwxraWplSqkPnjoEEqUfUIMMnltGDgTNJrDiqvOjPTmWTMQeaDhLCJAUzkjjqJtaVSELJvUTGuXwHzkjYZbZjiQdgnpMGACYgqzOtSDTuwwZAzTzMbDjLIWEnUoncCemvogoOjOloWnjOptUeIUKOPfWSZgMPoepupPDWbXqSjCaMZzWKByKsGKNLfXyeOfRtBkEuUYquYKnsnkkAZWDvYwYIxsezSgZcyWKHRBazjHDySLKKInaIUHpxCznbUaWpNaxqtRoRewxhudoDUhyFxWccAkdBLnpDlEhzdlRRBPrXxpFlVsxwrppNTeXVsOTWzhzUTwIrdlVoWCxPMwxqbRuxMhyyaPYlGCnyKNEWklwfiRCxWczhkvrVCtNdUTVzxFQHLjZFwVHhdkhCfUgXjzmcGtaPQNStrNfuBGwsUYHrBgPMqaUFRmdeIczp
    Should Contain    ${output}    grating : MsixeGKUjWxYRARUeXlFkHvocdtjztgTUriUTjkHUSlIhmYDYndMmPUcwguiGvvErkbUvTItSZPcfELByhcXQDWXZhafjMSdhLqlUGhgFglyZpADryzZvhdCCMqNiKskkHelCDzVOfqIvdaEniIhEhRZZicPQVHRDevIAzQJIozybqipOlZjcVGrddPMxRhwYxKJPtUJzypXwOoeHegWSczmwVOKlHMizwBGGUPpukrqqhxLAVZfayFOcoTkKQPLptcfAApgFeuneQbGSDraknbAKbmRDnOizxONJsojcpZkcrndujgyiJAzXecAqGPqarnkaAIVAkpsligoFPsjlviyIFElpGuiDzaFGbwkDfCjXmDJApGESbpfiNpdLneganKzdatfEPRWWGnETucQvPTIgZHlktOBhvpqkHELQrlcIjIXUguQBIyLhcJYCMVlIMzMUWozEjIGOXiHwkyznQORGngCBCsUvZHoAbxxbYJBFIrdMRnOgfRNxILOZBuyqTkRWuZckazXRudrnkMNdegBjxbaOxGwoBirTMsh
    Should Contain    ${output}    request_time : OjWDarRaUiFWtEdcKMhiBtniNTYqqprGSYZXHpASYBRcbLjuTigWDFcdWEDmKEInSUKmrMtmopVHRHmdnUKouuFqCnyWlDWpkFxErgZfYtrpZkfVEhJwBmpwyNuxjKEbiZxwJaMCoDAKqgblVEdKeyvNCxWavyRpSrsCSWdKyrqPCLqdqkkXrtmckCV
    Should Contain    ${output}    request_mjd : SRlbjrlaVthAacFixgUdLURGFaZoMappYtADlEhYJLjgyVhzMMDDdZhrYkhqpZPKTKOByRqkTrrgjcuikZYITlPHmZdVzIDFIqSqFoGEPNhLIOXxkBBSgzOrgTAoNuVriTyOtCFOHIwKPjbvlqTFGwdfEyeecNHLpxNEhJwByRIKLrghCBTwnZdKnJjpTSmCzdrgsxVbFxPeomylqZPGEnNncdOdapBUXmhVYatCUblprgAvvaQFAuhWLnfeJWAPCuhCUosuncRINyBrMHftpdPHDHLqMffueHhayOpvUraGinkuhqRkLjuxuUjvxJAqfyvchTnRDHtGdbsipfuZnFIRAiwRbMzySwwGSLKMLdyObpTzYzBQanOXlEMdCVgJSCWumTXzXzizFKUFLhDwnXbaldokrSqNWVLehTEhHLPSPScYwLkdheBaGGAumzWBlKiaELuKQQIDMDlnWwoGTHPwucJUZBtQjMzCcZLVjFzbMBGtVYHGWioQzUqXSmRbohJRJSuErcBUTBBVnxAIgXWlFdQrWeYGgSvyxzqGKpGxNGYRHodyfxHGrhqNlMFreCoYYRUvncAEMXuKdnkoXDPGvGhioOXZgeYJpDlaVfOjHOxEusDmOSjxWyEoZhIFWVnUYNjqXzbXhbcKCxsmymxZEqQYMjvRxnQkSXrPmFZFZACrLhhsxMzKWngSPXsEWBcsSQnvyODkjhsoWXZRczhAINTRkwEonYjKRFmiOWJuWfnjvZwiSbfRknYeluzQhGLtVrNJjtPLNDrIqFEOVMExIBZmYXKDurtSkKPtHuLCwafivZBjjvQWfDRzGYgKcFFlJvaBQlzGtQHKXfSUAVXdekAexYwfNyjyxbBvqdlbjoycIUQsgETiSpy
    Should Contain    ${output}    ra : PSrHgpWqqBfZiuXlUAhmFbLldprwvDgjShkpUcgNNzPFHNQEnNSBocEdmeXlTyjlklMYBAuUwWyZotEDbjTflLopEfFqWIlXKrUZogdhaPCTdmhupJyxqyRVtgJpzgkpsYzWmRhlKzjhOwxYBYQIUCOLfexWaQBCTAzoyTIENJwMRQlBQKDHlMTcfQeWIKPRzyRJIMGwyctlIGEZOyQeCYaTBOTmgMsSRGojtxVYTHvOzvbfKbOkXCbwevsxPkoPiMVvONxGHSJxeebOZbpXdnAvxTRdQjojvOseqnrKCTBbTLFOTSfrUUKoMqUxCAxkSlGEyCkahPLVaKpUVkIRlylQksYGKWdQwgkEySiwMaJbTHWykQMuZaYtIQDCjZPDVWWJmdnLOWqUVLZdSsATWBqudkBlDdpAUkdgoILgaRQzFXVCtXPFFocYmAIOirHztjlwUYInHVxgJzBAjEHxAhCyjkEczOmNEoOPaOxQjgctdkMecIuCDmVOYcbqAjxHqMRUuiJtpVbZED
    Should Contain    ${output}    decl : vmlEjUJzginPjehlzsHxmZwhUJNZWlaSmBTHTstBDyrWZnFYnowXtWtsVHlNAxfrqhidWVxlfSKiqGjGDloWRZwPCUStTiNkAJRPYdKAlHBHpudYjxIHAeFAfGjqfSLFZppUIDqVAyOjvjuXULPuePJnEpLMweuc
    Should Contain    ${output}    angle : jQeHngOJyRgcVYRCojKcazwpHBPcSlOJLJlQQdfADVmOFRMYgxNEpUCWqHWsrJrfBqeTRGoVkBtAxMCeYQZVQZSNlokBTLDSPflewtqbfPgBOxcBxdLcDcPaQOhFgSTemqhkahrnCXwDqfdtsgDpdGWOfQjNCIBWpVHVEsmPQOpgiQDPcizGFezuTxaXOcIDqDyOEnpGGpBrQBiDEydfItVctBYTwEAlINpPKdGhGyVrGQTnsjMQKzaATqKQCxjwSkwLWJeNFtBqpEpmPEysipKSbroKNRmcZzIkjFayPgbprhlizGYEaEiNkRwHWKcwzVcDvBpzzAUPnNkbgVuabyfQFADhXdWWrWYHJbdChzZSDWVWjZGPHGCvANPlpuVFojKMoMHaVEuRdqMRKNqTyUmEQuLCxYFVEtTWwqXictljyalakQQabSxVgMgjkGTUSsZJpvUanroUPOfeYIoZfcckprEBKtNWJXHSWZvTJpYalQFBuwCPsQhEqfBlyhHjIRTJZtjpcZrGFRMrmZoJWRrzAnKNzRBHKeueiIEynXkEqFoXpVpwrvCdfywqsrxnmNmTwxOnoNjzsefwfQJqgNwsfBHOUDzIoHgSJSwRFoEeUZfIrhrDybszzQoibDtklcUszTWRsePVFpRdiQeJtXnnzOYBvkyUlwUuVfRDVcNHSmXuoAbDBxdoneGYOikjpcpVOYXzbXClEuhlSuQusarHRyUBYDsgtIxbmFOCDEdnhnoWNSmeecCiwJWlXeVPplBEkAivQEtMnAhmxsIZAinekJh
    Should Contain    ${output}    num_exposures : wFeEuRVJCPLujRnLtwXgqioagXoDWEPNsyIOVLCYWejYwPjudIIeKWnOjvlztJKtKIjIgkDutfLqvJxABQlqMtUNSCQncYfNYTMqFPLKMikYARfeqdNMSUQwNFnmuToXkfRcselsIwoEvjAULHRoXtlAufWEXWYyirUNLvxjiRExZcTExuCuirBBhsziKfCZtjBBiaqNchmWYExOFuuSCTiIQATTbaKredPlKYFntYjDpoFKqouocUrtOUNKujiHjTQNfbRHDqbMvYqRtGyvoXOuGEaxGYzdGUMvCrofFGGkvCBKuweTXEQOvbQWzZQFqBzvZITUkjlUaYVPXgNQvqSwgrvpcJqANEjZRDdJuzAnyaaJsJNRHYmhHMrZDMNJbIFWYhIvspCKUPankfBbeEqcCSwwHtZlVFQcOdsTzzKsS
    Should Contain    ${output}    exposure_times : MhLOIbnulNvuBlaruVWvDULbIwlXbbxiutjgnQNUXyoUzgUnTRGmXXWHDniyifLS
    Should Contain    ${output}    airmass : NWOPddkoCHvjvRVyTnPBCXTVwblJjotVhIVhKuhXpUanJAqjYzzavWVKebxvrPEmNSZPOxzatxbkofxqvRhdzSkNByjSFkjVEKXzOnPlyliLizGBQgvOxGXTjbBANLWXprnyxJIBYoGrEhmtsvhiGvmugQfjLkpcyCmYivFiJZfgBYdniBFjbeLqZKDHpwJgniQSlgBwdoBWCmHiPDnaHmgDTgmcSnnmkWAVbTuTGayyrmIzKwypREobthzKwuCczkkOdMNsPFaFAGnXOWDUJrPnsUaNHRKGoTnZKmLIFwQQgwyetTreXnTNQHiTQXfQSgXhKvFKMdilhpzQruACBKhACLRiTvmBZhneEPHjmTMhWsFwrVlehIfVqczpcnzDNuilyKYoMUGiAasVAzrjvuEyThylxeVJhzucFiFOvGXMOhPjEXEppzBfPSHvPKgmNJtjNTrEuEpQncpWUrSicclhuTkxSoMDUAjwJSEErWrxGocoFZepwDqRZpsDyHnWIHfEphuWfiariijxucJYtZcceDviPHiBVpqMLWcevKVfrtLYLWzYlDemsEoUxSzBbkquZYFwJJeNHhFPfzwVEreQjBklkVDheTZGXNtDOsfbEPogPHgADJvDyqKDzfyPfTHRZEszwynVZiTiuEnELRXsZhhcghjeLGXdJigpXgLmoIVxMJLxcJLxqW
    Should Contain    ${output}    sky_brightness : qHsSLCDALYzhKeAXpraEasfomyZmYJVgMzFHRcsgytdnACrqXFLRbaLzITHCzfHikfTVCzdyuulycfjeNcMJMCIRrSCFnOlvRFaAoSZKxnvHgNBEDDJllVrnsIIqZlIzAkoqMZXnPikeboDyephmrpjCNcKVGdQOSONWAeziafuRPgALNHBYIzHHsccpfGBvskisIWAaRccBxQkXUZjRWCodzircWbPYPaXiArpqLtsSVIcgaqiDCYBSFykCNjuSNbtWzIHVGpjoXDiyMOzDXpSsODwUorLxrvXZvuclWTNdAaZtwGoTeeITQojJAMchcEMSGylwUsmAbWiHjfbBdfRSXPHbLEhNVmNHxarmJyPBgUTcKixKNXDRUsrkianUlHgSzDvyVuWtixSoHlgqRCNSdsRmcEuoWqFssxUIEFCigpichKHrebczfIIoRYTzNCjsyNXnDAmIJPxHYnihkydGoJYrIoFnteyXqpgHCYcDfylmXMwvyZkMKMbELVZXUnwyFzXaObOxahjcqknNUHoHEAqlCDMXeRYinvgFicsEoVTWNVcGQAgelSwxUxNcWNJRmokuwJNXNALUDYMojdLskrVamPtITeYLgumEeOFEKUIFfXZfWKCXLbzMpuCsuVEGWdRJTGkfSjqJeGcEVCBoiKyjcbayzIytEghfvVVirmbaVltrMvsbKTuOxRDXJNETSvNDaAhAccxgpeRmRVMZtiWGWHNHmlCSwuCxJGczCNlkdlfmpIwyhZOsJbqDFwZLmJEzgUjSSVLKysTPXrXmxRarTPlMugWcVOcjBfNPsDIXDHlGJvxCnUzuJhlxBzQBMLijublWNouBHgwJqFDdsqdaoQJFwcAqegUoxvlzTgHpOXhGaWULMWjqOrCoGIFkhXbGbdVmFRTqAmgXZDTZgOGcsfciCRQSxCObFnuipfeeQP
    Should Contain    ${output}    cloud : MVuPlHsXVmPByEVkJJQErSxldxMZfZSvpnZomqyXfFgwlAheFPzEhRTBpWvwiFXDoTtvsivALpipwwBOyXWkEHBvFimJvdkSEfTvZAkdwXjXimNFcWhuiPUdPVzzPwQnAtEHXBbQMSKrbBdhlJVPyZpLtiBPoGiYqAmIDPAlHsNxwqrUaljuitHTMrgLFyCqyAocUEBVopdjvccFoesjaOjzZauALOXoFzVZXzYbSkYXQMtbMTKjHBWjWWVhdnOZfCNxuDgOdcICExbdtOVwAzSazcjNiDDyGLAtbVlVOOWeAvfzReqdLmuesHNhtYQlevNTAVidrDFlfMcQSdrMIDkePcfsIxYXXUPcpvKlkOfxGAzxhorYSfnZwPzkoZjKSWxUOVDaWhzBCxqulLOBVyGGHPAVjPITVrqBjHnQWFgGlJgcsIopHeWYWEccuCgqlnGyKkwlRDYTYsEpTmqSOcaXhTuXasTTBttddAMaNQGWPgPMrHxduDxHVJsyMwZHjsNnXkriFxPsmZRnJuFjnfpCeLejewHyIGVujfbYLTdqulnWKqkosZoyyqasHGNoonNI
    Should Contain    ${output}    seeing : izaRekbMDPAaUZqPOqmvjBhqiOwLIZsulUpXpOVeafAkWcATRpJtzFlbNvwsxLYuAlPoSsscpnDwcOpNzEFSzzmqnrFLNrPmETYJHCEZbeFIQnuKNDDHyWobQYqshufwEmbROEAnzMSnxALnPvQDsJsqxcHwozwEDBPMUnobHyQGKXKmlbMnBGsDkjWEgyMDfCWfEjyDHGQFHKwsvBrYYbP
    Should Contain    ${output}    slew_time : HqJNmpkWBIFfviUAcTQRCaZoFPdeuUvBLAIKBLyFxDPPQjNCCiZnEmIzUqAKBQSgLwepinxpLPPvWMwITnKEzSKwiWltzcGLkPFdHeKRqbeiLlBHsLEDjLVoXTZfxnpVEyIClHcswivUBzBLnnaubAKnNNwpZmvPdWFKygKAuXLspPTUgsGbhWlMYTSSMEdxZumUYYGGdbxvCCVbbQOotjknGWdddRGBJUcqcQeGkBRtwucrlBQjdrKzFlmRiwSKjxvsRthdpweCBZIyfrQIdCplmZAUxTELhyvutLkaqpyOvNVUJJfNjzEFpRmlhIXjKqHOsCMEPUEQNBcRoTCpjdhGkKrGynHRHLvNnzufgBVuGQQXgIFIwIazntZioMKkrBmHnMzTxvdfAFotTbVVFjQSvFFxgVcXmYWAaqMznGxcZgoNvgXCAingSmtJqnkyhfcXsDKDSwNeYKYhYOnpggSzTVFoBuIsRJhfmncAcQVXzRGqcWWpzyyngHbvgzXTytsPvXMcpHRGsaOobMRdpXZVEHmsGRfFqfxqDLuiiszTQbzaaXrVrFmfWSUvkRVKsjJbtVzkWsrNsRlNRQaEyVKflKwXIlNlXTXMVhVWmBjLlcdXzhqerVbkqCkuZmjdAvaPsexaZNknjGZrWIDyKjmUfxfqwunbmmPUPBikBpzQfDyPHZGWlpuyTGzrcKNjtobewDuQvaRvAkfNAyezpMzIUdHtNTniYKaYThSEclNzegRBMuRLuBlWqtkYXwCODsIqjdqbLRLpQuZBRbwvQkWNZXzrfoesAxAuVUWtXfpZUZJUUqtqBSvCXxVJanaPQTQEpjIziIYQmqDRh
    Should Contain    ${output}    stage : DFTfSDhCOFxViztlZtJGnAkqbcWtdfMKIUrEOeKGnNajwOLoSfMMZDoXZqsSVnvbNftvuYnPURevcWmRSvUbaNJVFdLohFRaezdKIcPBkhZrSaRaDtxwvDabQxLFacodDeGoifbzftbnCLQpHHPALeGVyDmBcXHATbxnEfpxuWFgyKuQfyGEdMgczCTUfPaHMfMIHPlukZNrWbNTyiIzQXFzPUdgnFrGkdcJuRvAMFEgJrybazQVqftMiaztnvLqKnYlhJXQyDKCSpmjqBZlXMhFJKReSXBGsUbUMlJaqIcwkUUioZsFNzptJwCIrHwbBhowvzfiNffQTKWIpQgyAmCaoawsXNLiuQhCNEykoPlAHZcsuCRyyZrITSUcpvwfnbPADCxENpgkKMFxktEQmkGFkGaPjIHHhykcZqugAXWYGLUkFgwyvnFjCMMzvxeJpdUPgfFeUqieXYiZsrErQkLPPnQSgNXRxfNN
    Should Contain    ${output}    offsetX : NQUtriRcNGPHJltDAPxvrodkonLRdBoOTHHFbKVVazRiWTCesMytXeKyGgXSRmiIDXHakCkAAHUcfkxIgWbkaqEcXKXrFykYEkWijmHAeyKwcySqonBjgZwSvDwHTLoVmPMyfDglHKoKQAYzdtmYcSYqiGAAeXoSgLLgnzKPWmPzOUCbJUBWvNfDVoYVaTBOlhPEntggbGPmguESZaIzzUyNDdbjtzkKWMKdFsstwkKhIatkZwXPEtpznSRNvcNSWfoKVxuIdvqCSxtGVOFedkYBScIqYbMGwfoyuRjItsZyQgsMkGKERMljyRWpidqFxeFRmLgxQTOFSNqVjwcFbgbDuWiQZu
    Should Contain    ${output}    offsetY : RkXyaPiYmkjNDudZMfVnoexQOfKqNplfAhKPrNofaBtjGUwCUcURPUfgxkbCWSgNsoUohgZHzeWmtKbDnrBZWtmkznyfLewndYIDEpIFdSaieqNhibfdnmWPXmJSKjoECoTBkoENLtrGqEpEseeooOzxEnOBZunvxNqrfRfehJIHJkdvVxPVeeWRHQbTrWoBUpVkcFcpgyvyTQHNGmDuTKynDNsaaKxPIshOcIugoWPhdOcsJhYKBJZDqwITIhpHjGjBJERVVmtvYPmkjhASstUdAfKVGzQIdxQjcEtOpFaOwhbAmZoMLThLSZYzRpnhBUxIJbkyHZbFPsfOCnslzrBxkkRBEsnHrjHNouncCBKzYOSfhINfiwrbIqtDTTfJovjeQfXyxzlJNDRJBxqStSccLBAnjpnoWbeMPfKZMlzumfwcPNHTJUroXwUxUjLsQykmviuxcaFgqgfKWkeNMJkNNegVgoawKCSBFABjiJMsptoMkhEOwukLIhfjZPltPLZGJCDeETxGooCsagaaLhAONKfLpouhmbngFmtyQfkONLmpraeqKOUSMWxavHiDCJvgJltlAHhFTzHninKjWiryFNENsVixuosImicTIqoPwUGeuKNcULpqQTZYmBgABTQPdgfkalDuoqTvXCMdyGxMIhSuVnfkfYpMvKAdTJZZtyisTgMWtDijImrqmyPIczGuuulmkpnhlVHhYFsqDcqDGVgffmsFdPfZWvXPOFUFailKYmxOKnOkfeyZChuoZHXLHuEjXLOMxxHGHunipnaGEbcuzyxExLVvYxLacMYMAOjfrYPltDIltfvqMwDkPksjaXnzbkuJwjVOPMlJdLOioPHjHGzBNOTLDBNiWFNzbhVlRMzFGevBvEBaJloPofKdBaPJSJobuvcLSHyhjWaRSQeYrEYpZKUVasexqUBurgWIZOZVEdCYxkWViqUVYTlBOEtQxVyZspLRceFltjBDH
    Should Contain    ${output}    priority : CAEUiRbhGehiKnCMugmNUnRZXInWNtZvqhUbVbzZRNIapTbxjexbGiPAnMaErUANtZglqWTzCFKfyJwwBOznTWSdBBjftDxopyLEEuIvNsaykwZbZNiuHXrwTubBjgZqyINUsSyAAsZFPkQXeZboUdvJNmnjJxPhJzAsqxtNYdnmLCnNDisqWwpcgFyczDYNvkcbKAhhpDDwXyrijieGLSmyGNOnPiMQZzYrmldAgKapCZPkSyAtoWYMooWMhrFYgwfSBHtyFpOGEJeVKWIfgvtOGeVCBFPPEuHTWLRmIdYAXxXfHMuXDLiULsurlBHjJkJYVpkIrWHXOvlTNvnITUbAOGpuNitBBCYlkvAzycqJIokeiPxIRbCfWhrvyfTmbEDAsrRgEzQhibJteuDlbklAebbpEbckAFkiqrEqaREjDWALHvGrmSNfPmKyoDOWPWgznJsIMfsOOLlZKekNtviXcqbnTkJXZcXRhXQutVJRlGlMFfirdtlmzSYfWbpFynVesNBpedAiHFEZnlCZGzoYBakzuaWKYQQDpyHiXBeyzNwAVBWwifiyPxAsxvOHDRofjqWFIdOkMAdKHOgykAztAaNuqKatlgceuAhMEKW
