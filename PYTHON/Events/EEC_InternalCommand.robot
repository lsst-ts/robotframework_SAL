*** Settings ***
Documentation    EEC_InternalCommand sender/logger tests.
Force Tags    python    
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 112 197 50 9 39 159 47 225 42 138 148 73 108 56 166 3 182 31 89 143 193 157 74 169 65 99 111 21 225 3 209 187 215 160 231 88 162 116 253 223 104 85 65 188 221 224 174 203 37 55 189 21 118 193 168 174 239 50 224 220 153 218 191 161 198 102 34 101 167 58 32 91 165 245 216 38 11 208 126 218 5 134 29 181 209 149 232 211 125 36 247 20 24 1 112 201 173 74 66 17 2 66 5 77 88 114 3 224 207 236 162 74 251 183 177 161 176 78 253 185 207 209 208 244 149 109 236 159 52 227 53 42 1 130 215 130 59 30 197 33 68 123 182 89 188 85 190 17 75 3 146 26 159 56 165 156 12 80 136 43 239 241 174 57 32 48 117 167 180 80 5 145 24 223 42 192 125 252 150 220 201 112 3 146 72 102 181 99 229 182 123 65 248 42 66 20 32 93 179 122 234 100 21 248 115 200 138 12 154 164 247 181 62 235 201 48 59 12 52 100 133 136 90 84 192 237 113 27 226 98 118 231 102 53 79 3 217 79 170 72 92 249 135 180 7 3 190 170 199 14 186 29 202 142 122 133 230 183 84 198 209 163 73 22 202 196 12 134 158 240 20 217 198 187 97 121 127 160 17 186 198 237 145 29 161 122 136 233 77 24 114 175 5 169 151 84 12 141 15 17 242 64 137 218 170 228 137 137 120 199 117 30 48 241 44 37 64 121 226 131 102 168 164 74 196 74 102 249 159 239 94 35 100 236 186 110 230 139 119 13 106 242 32 18 49 47 192 183 177 1 129 63 121 88 61 148 207 155 22 196 129 74 231 35 86 51 244 251 123 105 27 213 63 144 162 177 42 174 49 235 136 92 152 58 83 30 46 231 243 33 83 66 176 191 163 153 85 30 71 41 12 107 64 28 208 102 174 89 232 5 115 95 221 215 4 17 23 182 250 39 195 125 20 159 229 152 10 204 10 21 142 211 87 201 217 203 141 2 10 140 201 8 214 182 195 149 9 88 208 83 65 189 161 251 161 23 20 127 48 50 253 62 213 51 180 238 58 89 107 185 77 17 223 202 49 118 202 155 184 43 179 160 218 167 231 224 25 19 154 113 2 139 192 172 95 60 66 110 12 47 1 57 107 6 155 18 237 57 233 18 129 247 130 107 97 153 186 180 102 89 191 103 52 97 161 164 233 15 8 127 19 116 25 143 174 113 109 130 183 41 64 223 114 244 209 138 163 47 207 247 154 224 150 123 133 156 184 5 91 69 91 10 31 244 92 189 249 118 209 22 191 149 113 9 179 88 220 35 230 52 237 3 231 157 245 226 52 34 228 159 77 86 239 149 195 51 32 129 10 227 39 181 37 39 215 131 167 191 179 216 4 75 46 103 119 181 169 208 63 56 109 15 41 23 94 138 208 44 19 252 244 127 87 195 218 242 44 184 35 224 250 246 39 114 27 255 90 67 177 241 20 160 207 15 141 154 252 96 141 183 46 128 123 20 211 168 67 119 34 154 108 32 233 156 74 93 80 182 232 114 200 54 94 183 177 34 54 132 175 83 194 2 87 13 5 40 118 123 141 115 203 210 120 8 169 50 24 89 186 185 209 48 111 233 93 71 105 117 202 153 59 65 216 75 74 152 136 87 128 74 47 124 92 14 202 112 243 94 165 224 174 75 127 103 137 42 177 139 245 214 52 156 133 91 9 241 54 157 17 28 128 249 43 2 136 118 69 166 113 121 178 227 92 47 80 102 128 77 74 125 127 21 76 110 68 1 182 223 249 49 81 201 121 135 99 191 77 130 225 22 124 206 98 148 70 212 11 39 42 139 123 15 130 69 97 0 79 32 155 148 107 29 180 179 111 185 96 6 161 72 16 29 31 99 114 42 151 130 244 160 92 78 252 19 110 157 160 217 184 31 71 55 136 168 234 11 220 220 181 187 55 124 51 54 141 202 24 60 88 107 77 169 79 168 8 63 43 9 122 191 10 4 1 42 23 93 136 156 111 15 225 183 13 183 10 69 239 116 68 160 164 69 250 75 174 149 156 168 241 251 36 35 112 185 243 54 28 197 71 69 168 104 254 237 149 223 151 252 241 136 240 93 249 163 84 216 171 70 238 220 46 15 136 182 234 20 14 91 151 8 172 89 239 88 204 178 158 185 112 160 238 17 38 159 79 241 215 6 15 75 245 51 154 71 201 188 23 185 39 137 133 163 96 117 208 111 130 161 116 113 233 79 117 59 111 189 36 233 171 92 -1470432335
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
