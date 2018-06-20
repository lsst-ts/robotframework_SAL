*** Settings ***
Documentation    TcsWEP_internalCommand communications tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    tcsWEP
${component}    internalCommand
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : commandObject priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 142 220 224 173 243 130 191 52 10 184 118 212 198 70 244 89 165 83 73 7 169 147 35 115 202 107 175 107 33 78 88 68 129 70 189 50 82 81 83 79 42 213 73 94 48 238 230 160 27 255 208 195 22 46 133 191 216 152 59 45 155 190 204 77 52 131 212 239 185 169 42 85 162 198 156 127 35 171 62 109 217 114 67 71 106 90 98 124 230 220 114 245 237 53 20 136 126 6 20 222 210 39 86 176 60 206 160 12 3 184 108 10 61 169 163 152 11 112 178 168 209 85 105 169 237 218 34 22 241 243 127 254 163 204 193 65 166 76 110 43 64 136 66 254 89 65 224 102 42 130 175 177 173 216 218 132 195 39 130 157 191 98 107 76 6 24 105 47 247 47 209 157 230 37 106 25 35 119 206 14 30 2 143 77 18 190 143 81 130 185 222 242 23 147 246 93 133 231 251 88 41 237 194 140 61 244 86 198 114 111 127 227 233 143 16 147 5 60 82 7 25 202 176 196 163 164 121 210 71 250 251 51 61 217 104 9 159 105 65 94 234 162 203 215 86 177 12 120 150 204 151 197 73 228 0 56 3 204 133 173 218 241 71 109 20 241 12 51 159 109 148 123 104 107 80 26 177 225 242 157 111 13 234 85 166 107 8 148 59 169 154 47 15 131 144 62 207 38 23 85 245 159 102 25 122 144 45 201 199 156 17 59 218 115 28 66 41 113 141 0 173 30 243 31 197 149 181 184 245 20 255 194 40 25 134 59 239 208 95 27 231 46 168 204 55 215 131 137 163 186 66 200 135 204 1 238 206 213 127 94 176 7 150 10 183 175 246 40 127 224 37 100 130 13 189 158 163 181 52 55 59 40 59 28 128 31 212 119 43 153 203 7 185 194 88 245 117 130 189 160 171 95 169 134 4 119 247 185 48 17 156 116 51 172 9 12 65 24 160 167 230 113 42 194 61 195 232 7 97 119 254 51 130 191 207 194 167 119 85 102 125 121 32 151 61 147 189 66 251 203 147 167 10 136 131 64 66 226 216 127 153 254 189 232 252 38 216 23 77 212 196 108 181 122 27 54 17 199 33 203 68 13 91 219 226 85 55 108 77 132 130 43 31 186 129 3 230 176 193 85 243 24 71 160 232 57 40 86 197 144 113 208 5 69 10 30 172 23 80 61 118 158 23 127 64 120 93 221 84 205 167 242 84 17 95 94 231 157 213 203 48 107 175 212 109 127 62 55 39 182 10 19 150 14 47 225 139 87 101 154 101 142 163 64 103 104 51 21 198 6 162 194 185 241 24 141 134 47 185 18 7 157 140 60 192 211 96 174 117 202 84 91 46 74 198 243 178 106 183 36 230 161 142 85 217 217 128 241 79 21 75 230 101 108 226 26 153 99 199 212 47 165 242 102 89 166 230 175 136 36 145 67 138 0 255 135 187 187 169 171 248 162 68 3 113 200 40 105 185 152 243 204 145 219 236 232 226 22 253 93 75 23 220 31 55 114 24 26 208 214 218 148 22 84 149 225 101 197 1 216 232 62 114 229 98 209 126 22 31 88 77 37 175 45 159 132 19 24 163 96 113 37 112 69 109 156 132 183 22 228 134 211 59 9 183 148 134 120 29 139 171 227 131 215 118 76 238 208 0 123 103 183 246 71 71 204 95 152 5 38 138 111 211 70 93 92 101 216 108 74 196 139 170 156 41 203 64 238 120 193 255 5 239 13 85 57 137 92 18 17 233 235 17 1 29 181 180 209 45 156 158 82 146 251 244 110 80 74 225 119 1 191 109 50 213 23 94 154 70 209 -1233430063
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] tcsWEP::logevent_internalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
