*** Settings ***
Documentation    EEC_InternalCommand communications tests.
Force Tags    python    TSS-2724
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    eec
${component}    InternalCommand
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : CommandObject priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 107 107 242 84 244 53 91 19 14 220 51 193 180 221 117 186 181 152 31 239 168 69 254 52 106 202 249 79 189 123 218 106 204 217 210 157 80 79 59 197 215 25 79 10 88 163 40 60 86 162 132 33 75 76 186 216 102 33 131 235 56 79 27 241 56 168 64 106 181 10 132 60 98 116 43 120 183 90 26 98 185 117 146 59 3 84 241 219 77 14 86 125 13 205 38 183 201 247 90 60 233 250 74 117 185 185 139 39 239 250 86 3 185 155 22 192 10 57 92 161 221 23 192 69 201 29 178 66 34 207 229 84 186 205 121 165 142 86 239 60 123 54 233 243 155 56 91 217 39 183 114 88 25 34 209 160 69 130 15 135 165 73 132 15 115 174 209 35 71 213 246 179 54 79 151 103 124 244 127 253 71 121 146 234 179 247 105 94 243 126 231 193 47 172 76 241 155 168 67 13 56 58 153 20 55 117 86 190 146 34 145 3 101 12 116 173 26 156 173 192 136 211 237 84 154 21 115 254 106 204 177 126 37 63 61 146 23 28 174 224 85 5 142 120 20 143 1 247 252 14 2 162 187 129 76 114 7 228 70 35 114 186 109 43 158 98 225 106 214 152 7 40 231 157 255 24 132 98 252 154 37 218 85 246 76 138 65 244 253 17 21 102 39 199 163 219 66 195 20 58 40 72 85 220 161 153 145 113 203 99 222 190 27 185 155 241 227 201 236 121 222 5 92 176 65 184 12 118 26 89 85 239 149 99 229 227 198 4 42 94 88 117 120 46 8 91 30 156 136 124 249 225 152 116 241 232 41 106 250 18 135 178 155 172 140 234 107 47 190 15 111 88 182 174 124 35 132 137 239 218 38 212 116 220 183 214 93 81 99 152 245 73 167 236 224 164 135 195 92 96 157 154 125 160 201 119 122 182 71 158 10 99 172 231 64 201 123 61 243 13 61 196 185 245 180 113 66 122 15 227 147 33 38 20 225 128 19 254 27 58 108 80 20 91 198 250 242 232 143 49 81 248 198 100 180 84 180 93 199 91 130 64 9 255 3 202 145 205 72 10 19 146 154 105 107 52 65 91 53 174 149 207 46 32 65 171 138 223 225 102 163 24 231 116 91 157 48 226 183 13 115 205 198 84 43 13 91 153 190 34 25 164 167 117 130 79 36 12 235 106 208 101 30 28 122 148 140 102 248 136 173 248 138 101 181 243 12 158 140 184 179 146 202 245 193 143 92 216 28 238 124 55 143 156 119 253 57 158 108 71 168 87 16 100 8 190 88 61 146 59 186 231 3 137 48 151 210 166 25 19 234 137 8 162 147 55 125 185 202 163 44 61 1 113 2 5 108 116 190 61 157 1 216 70 218 18 174 70 208 134 109 25 180 205 157 203 89 71 60 246 173 162 157 143 129 185 46 65 184 182 207 78 15 19 240 225 189 79 209 21 220 65 114 47 112 30 70 155 141 61 52 173 254 49 205 35 44 60 178 70 85 50 240 16 74 71 102 140 245 55 135 154 183 205 200 11 171 31 139 198 113 179 79 176 50 230 243 178 233 17 185 172 72 4 71 165 117 235 137 184 228 118 125 137 249 178 9 128 226 223 172 115 161 254 221 93 43 15 131 154 99 91 19 173 245 29 7 114 199 149 107 200 236 22 72 224 187 249 93 248 251 35 124 59 242 219 51 236 184 183 45 123 128 48 245 63 32 160 6 207 153 143 169 36 67 81 198 120 2 185 31 254 255 109 114 150 186 129 211 169 123 27 150 157 165 51 94 99 246 143 91 89 228 226 25 19 128 230 222 209 12 255 56 198 107 89 206 218 151 68 132 13 17 87 203 207 235 53 83 146 222 10 95 76 11 49 208 178 99 130 162 90 196 45 194 122 66 124 86 9 66 97 209 194 140 15 180 174 32 0 156 11 233 48 71 197 98 7 222 237 10 28 230 250 191 56 150 254 204 204 85 159 230 135 21 189 25 218 69 33 87 160 21 187 218 137 19 35 115 254 32 180 130 211 122 222 92 192 253 216 25 95 11 27 74 58 76 138 187 81 164 15 129 90 197 45 69 216 248 53 128 173 82 112 101 135 76 47 71 229 131 1 223 107 124 226 103 253 54 159 152 103 215 132 206 70 48 254 1 137 136 237 180 60 35 196 182 224 153 196 174 9 187 184 189 170 147 79 79 144 221 86 54 74 19 245 128 46 227 95 231 71 36 253 201 152 215 214 215 209 239 175 159 93 131 26 58 172 22 155 -180519572
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] eec::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
